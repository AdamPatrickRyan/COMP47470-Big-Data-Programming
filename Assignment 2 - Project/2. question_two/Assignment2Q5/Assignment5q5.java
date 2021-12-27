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

public class Assignment5q5
{

  public static class TokenizerMapper
       extends Mapper<Object, Text, Text, Text>
  {

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

		word.set(routeNo);

		//Send the instances of the port
		context.write(word, new Text(port));

        }

  }

  public static class IntSumReducer
       extends Reducer<Text,Text,Text,Text>
  {

    	public void reduce(Text key, Iterable<Text> values, Context context)
		throws IOException, InterruptedException
	{
      		String resultString="";

      		for (Text val : values)
			{
       		 	resultString += val+"|";
      		}

     		if (resultString.contains("Midnightblue-Epsilon"))
			{
      			context.write(key, new Text(resultString));
    		}
	}
  }





  public static void main(String[] args) throws Exception
 {
    	Configuration conf = new Configuration();
    	Job job = Job.getInstance(conf, "word count");
    	job.setJarByClass(Assignment5q5.class);
    	job.setMapperClass(TokenizerMapper.class);
    	job.setCombinerClass(IntSumReducer.class);
    	job.setReducerClass(IntSumReducer.class);
    	job.setOutputKeyClass(Text.class);
    	job.setOutputValueClass(Text.class);
    	FileInputFormat.addInputPath(job, new Path(args[0]));
    	FileOutputFormat.setOutputPath(job, new Path(args[1]));
    	System.exit(job.waitForCompletion(true) ? 0 : 1);
  }

}

