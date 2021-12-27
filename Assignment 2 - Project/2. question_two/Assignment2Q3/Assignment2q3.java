import java.io.IOException;
import java.util.StringTokenizer;
import java.util.HashMap;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

public class Assignment2q3
{

  public static class TokenizerMapper
       extends Mapper<Object, Text, Text, IntWritable>
  {

    	private final static IntWritable one = new IntWritable(1);
    	private Text word = new Text();

	public void map(Object key, Text value, Context context)
		throws IOException, InterruptedException
    	{
		//Get the row of data - comma delimited
		String rowData[]=value.toString().split(",");
		
		//Columns in the dataset
		String port=rowData[0];
		String porNo=rowData[1];
		String route=rowData[2];
		String routeNo=rowData[3];

        if (route.equals("Carnation_Sixty-seven"))
            {
                word.set(port);
            

                //Send the instances of the port
                context.write(word, one);
            }
        }

  }

  public static class IntSumReducer
       extends Reducer<Text,IntWritable,Text,IntWritable>
  {
    private IntWritable result = new IntWritable();

    	public void reduce(Text key, Iterable<IntWritable> values, Context context)
		throws IOException, InterruptedException
	{
      		int sum = 0;

      		for (IntWritable val : values)
		    {
       		 	sum += val.get();
      		}

     		result.set(sum);
      		context.write(key, result);
    	}
  }





  public static void main(String[] args) throws Exception
 {
    	Configuration conf = new Configuration();
    	Job job = Job.getInstance(conf, "word count");
    	job.setJarByClass(Assignment2q3.class);
    	job.setMapperClass(TokenizerMapper.class);
    	job.setCombinerClass(IntSumReducer.class);
    	job.setReducerClass(IntSumReducer.class);
    	job.setOutputKeyClass(Text.class);
    	job.setOutputValueClass(IntWritable.class);
    	FileInputFormat.addInputPath(job, new Path(args[0]));
    	FileOutputFormat.setOutputPath(job, new Path(args[1]));
    	System.exit(job.waitForCompletion(true) ? 0 : 1);
  }

}