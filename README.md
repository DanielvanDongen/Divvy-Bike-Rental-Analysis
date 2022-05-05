# Divvy-Bike-Rental-Analysis

First Project using Divvy-tripdata(Bike-rental)

This case study was completed as a part of the Google Data Analytics Professional Certificate.


##  1. Ask Phase

The key businness task for this project was to analyze how casual riders and cyclistic members use their rental bikes differently. <br />				
The result of this analysis will be used to design a new marketing strategy to convert casual riders to annual members.
	


<p>&nbsp;</p>

##  2. Prepare Phase

### **Download data and store it appropriately** <br />
The data used was downloaded from [DivvyBikeData](https://divvy-tripdata.s3.amazonaws.com/index.html). <br />
Local copies have been stored securely on Google drive. <br />
For this analysis only the Divvy_Trips_2020_Q1 data was used.

<p>&nbsp;</p>

### **Structure of the data** <br />
The analyzed Divvy_Trips data is in comma-delimited(.csv) format with 13 columns.

| ride_id | rideable_type | started_at | ended_at  |
| :------ | :------------ | :--------- | :-------- |
| `id`    | `string`      | `DateTime` | `DateTime`|

| start_station_name | start_station_id | end_station_name | end_station_id |
| :----------------- | :--------------- | :--------------- | :------------- |
| `string`           | `id`             | `string`         | `id`           |

| start_lat  | start_lng   | end_lat    | end_lng    | member_casaul   | 
| :--------- | :---------- | :--------- | :--------- | :-------------- |
| `latitude` | `longitude` | `latitude` | `longitude`| `member/casual` |



Furthermore another table was created(triplength) in comma-delimited(.csv) format which displays the ride length of each trip.
| ride_id | ride_length |
| :------ | :---------- |
| `id`    | `Time`      |

The ride_length was calculated through simple functions in Excel. <br />

<p>&nbsp;</p>

### **Credibility of the data** <br />
For this case study we will assume that the data is credible because the data was compiled and published by the organisation.


<p>&nbsp;</p>

##  3. Process Phase

### **Used tools** <br />
For this analysis I mainly used SQL to import, clean and analyze the data available. <br />
To visualize my findings I used Tableau. <br />

<p>&nbsp;</p>

### **Importing the data** <br />
To import the data in the SQL workbench two tables were created(tripdata, triplength) whose structurs is the same as shown above. <br />
The data was imported into the tables using the LOAD DATA INFILE statement. <br />

```
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Divvy_Trips_2020_Q1.csv'
INTO TABLE tripdata
FIELDS TERMINATED BY ','
LINES TERMINATED BY "\n"
IGNORE 1 ROWS;
```
```
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/trip_length_2020_Q1.csv'
INTO TABLE triplength
FIELDS TERMINATED BY ','
LINES TERMINATED BY "\n"
IGNORE 1 ROWS;

```

<p>&nbsp;</p>

### **Cleaning process** <br />

Different query's were used to determine if there is any invalid or false data. <br />
The first query determined the maximum and minimum triplength: <br />
```
SELECT max(ride_length) AS Maximal, min(ride_length) AS Minimal FROM triplength;
```

All tuple's whose trip length is zero have been deleted, as these trips are invalid and do not contribute further to my analysis.
```
DELETE FROM triplength WHERE ride_length = "00:00:00";
```

In addition, all tuples in which empty values appeared were searched. (No empty tuples were found in the dataset)
```
SELECT * FROM tripdata WHERE end_station_id IS NULL OR end_station_name IS NULL;
SELECT * FROM tripdata WHERE start_station_id IS NULL OR start_station_name IS NULL;
SELECT * FROM tripdata WHERE started_at IS NULL OR ended_at IS NULL OR member_casusl IS NULL;
```

Finally, all columns that were no longer needed were deleted. <br />
These columns included: rideable_type, start_lat, start_lng, end_lat, end_lng. <br />

These columns were deleted because the rideable_type in this dataset were all the same: "docked_bike" and the longitude and latitude are only 
helpfull to determine the distance in a straight line it doesn't determine the real trip distance. <br />

The new structure of the tripdata table was the following: <br />

| ride_id | started_at | ended_at  | start_station_name | start_station_id | end_station_name | end_station_id | member_casaul   | 
| :------ | :--------- | :-------- | :----------------- | :--------------- | :--------------- | :------------- | :-------------- |
| `id`    | `DateTime` | `DateTime`| `string`           | `id`             | `string`         | `id`           | `member/casual` |



<p>&nbsp;</p>

## 4. Analyze Phase

In this phase the main target was to discover the main diffrences between casual riders and annual members. <br />

The first step was to determine how many trips were made by casuals and members. <br />
```
SELECT COUNT(*) AS Amount_of_casuals 
FROM tripdata WHERE member_casual = "casual";

SELECT COUNT(*) AS Amount_of_members 
FROM tripdata WHERE member_casual = "member";
```


The next step was to figure out which start_stations and end_stations were used the most by casuals and members.

Start-stations
```
SELECT start_station_id, start_station_name, member_casual, COUNT(*) AS Amount_of_trips_from_each_station 
FROM tripdata 
WHERE member_casual = "member" GROUP BY start_station_id ORDER BY Amount_of_trips_from_each_station DESC;

SELECT start_station_id, start_station_name, member_casual, COUNT(*) AS Amount_of_trips_from_each_station
FROM tripdata 
WHERE member_casual = "casual" GROUP BY start_station_id ORDER BY Amount_of_trips_from_each_station DESC;
```

End-stations
```
SELECT end_station_id, end_station_name, member_casual, COUNT(*) AS Amount_of_trips_from_each_station 
FROM tripdata 
WHERE member_casual = "member" GROUP BY end_station_id ORDER BY Amount_of_trips_from_each_station DESC;

SELECT end_station_id, end_station_name, member_casual, COUNT(*) AS Amount_of_trips_from_each_station 
FROM tripdata 
WHERE member_casual = "casual" GROUP BY end_station_id ORDER BY Amount_of_trips_from_each_station DESC;
```


Then the number of casual riders and members who had a 00:01:00, 00:10:00, 01:00:00 or longer ride length was analyzed.
```
SELECT COUNT(*) AS Amount_of_casuals
FROM tripdata NATURAL INNER JOIN triplength 
WHERE member_casual = "casual" AND ride_length <= "00:01:00";

SELECT COUNT(*) AS Amount_of_members 
FROM tripdata NATURAL INNER JOIN triplength 
WHERE member_casual = "member" AND ride_length <= "00:01:00";

...'same code for other ride_lengths'
```


The final step was to analyze in what time frame casual riders or members would ride the most.
```
SELECT member_casual, COUNT(*) AS Anzahl 
FROM tripdata 
WHERE started_at LIKE "%00:__:__" GROUP BY member_casual;

SELECT member_casual, COUNT(*) AS Anzahl 
FROM tripdata 
WHERE started_at LIKE "%01:__:__" GROUP BY member_casual;

...'same code for other time frames up to "%23:__:__"'
```

<p>&nbsp;</p>

## 5. Share Phase 

### **Determine the best way to share my results** <br />
Visualizations were created using Tableau and the summary of my project will be uploaded to github.

<p>&nbsp;</p>

### **Creating effective data visualizations**


![numbers_M+C](https://user-images.githubusercontent.com/104349890/165116331-ca99af64-9785-4791-9da1-487aabf32d69.png)


| start stations casuals | start stations members | 
| :--------------------- | :--------------------- | 
| ![most used start stations casuals](https://user-images.githubusercontent.com/104349890/165123604-2f416b87-32ec-49e8-8196-a9437c586128.png) | ![most used start stations members](https://user-images.githubusercontent.com/104349890/165123704-f627886e-879a-4838-85d4-eee0b5789b7a.png) |                   

<br />

| end stations casuals   | end stations members   | 
| :--------------------- | :--------------------- | 
| ![end_stations_casuals](https://user-images.githubusercontent.com/104349890/165123987-eb69dcd0-632d-49bd-9693-45cdbc4b4f7a.png) | ![end_stations_members](https://user-images.githubusercontent.com/104349890/165124029-db7ecdda-dbd1-40fe-86d4-e0d660f446a8.png) |  


![ride_length_C+M](https://user-images.githubusercontent.com/104349890/165279405-485f3fc3-2ce0-41e6-b0a6-0e3118f253c3.png)


| Timeframe casuals | Timeframe members | 
| :---------------- | :-----------------| 
| ![timeframe_00_23_C](https://user-images.githubusercontent.com/104349890/165278368-126c09ae-c61a-497f-a730-97538a196c5a.png) | ![timeframe_00_23_M](https://user-images.githubusercontent.com/104349890/165278389-3cca0668-6db8-4eae-8b74-d7b95d791755.png) |

<p>&nbsp;</p>

### **Summary of the analysis**

Here are some key obeservations emerged from using the analysis and visualizations above: <br />

- Casual drivers tend to use different start- and end-stations than annual members.

	- The most used start- and end-stations by casuals (HQ QR, Streeter Dr & Grand Ave, Lake Shore Dr & Monroe St) differ strongly from     		those of the annual members (Canal St & Adams St, Clinton St & Madison St, Clinton St & Washington Blvd).
	

- Casual riders are more likely to use bikes extremely short (<=00:00:01) or extremely long (>01:00:00).

- Nearly every trip made by members have a ride length between 00:01:00 and 01:00:00.


- Most trips mady by casual drivers occur between 12:00 a.m. and 5:00 p.m..

- Most trips made by annual members occur at working times 8:00 a.m. and 5:00 p.m..




<p>&nbsp;</p>

## 5. Act Phase

### **Final conclusion**

The business task was to discover how casual riders and cyclistic members use their rental bikes differently. <br />

The main differences between casuals and members:
- starting- and ending-stations
- trip ride length 
- time frame in which the trip will be carried out

My recommendations for the new marketing strategy are as follows: <br />

- Most casual drivers tend to use specific starting- or ending-stations, marketing should concentrate advertising on these places as well as giving information about the benefits of using the annual membership.

- Promote your annual membership by advertising lower prices for longer rides (>01:00:00) so that many casual riders who frequently use their bikes for long rides will consider switching to an annual membership because it saves them money.  

- Most casual drivers dont use the bike at working times which implies that many of these casual drivers are using bikes for sightseeing or the like. Launching a sightseeing campaign to give casual riders the opportunity to use the bikes to visit all the major sights of a city and offering a matching annual memberships which is less expensive than paying all the trips individually.
