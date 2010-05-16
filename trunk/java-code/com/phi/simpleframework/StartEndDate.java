package com.phi.simpleframework;

import java.text.SimpleDateFormat;
import java.util.Date;

public class StartEndDate {
	public static void main(String[] args) {
		SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss.SS");
		Date startDate = new Date();
		long startTimeStamp = startDate.getTime(); //returning a timestamp

		System.out.println("Start: " + df.format(startDate));
		
		//Your code here
		
		Date endDate = new Date();
		long endTimeStamp = endDate.getTime(); //returning a timestamp
		System.out.println("End: " + df.format(endDate));
		System.out.println("Diff: " + (endTimeStamp-startTimeStamp));
	}
}
