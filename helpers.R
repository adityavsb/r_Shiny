# Data loading and preprocessing
load_data = function() {
  data_url = "data/yelp_academic_dataset_business_small.csv"
  full_data = read.csv(data_url)
  rest_data = full_data[grep(pattern="Restaurants",full_data$categories),]
  
  rest_data = data.frame(rest_data$business_id, rest_data$name, rest_data$stars,
                         rest_data$longitude, rest_data$latitude, 
                         rest_data$state, rest_data$review_count, rest_data$full_address)
  # Drop incomplete businesses
  rest_data = rest_data[complete.cases(rest_data),]
  colnames(rest_data) = c("ID", "Name", "Stars", "Longitude", "Latitude", "State", 
                          "Reviews", "Address")
  
  return(rest_data)
}

selectImage = function(n) {
  if (n < 0 || n > 5){
    print("Error: number of stars is not within the range")
  }

  imgURL = switch(as.character(n),
         "0" = "/5_Star_Rating_System_0_stars.png",
         "0.5" = "/5_Star_Rating_System_0_and_a_half_stars.png",
         "1" = "/5_Star_Rating_System_1_stars.png",
         "1.5" = "/5_Star_Rating_System_1_and_a_half_stars.png",
         "2" = "/5_Star_Rating_System_2_stars.png",
         "2.5" = "/5_Star_Rating_System_2_and_a_half_stars.png",
         "3" = "/5_Star_Rating_System_3_stars.png",
         "3.5" = "/5_Star_Rating_System_3_and_a_half_stars.png",
         "4" = "/5_Star_Rating_System_4_stars.png",
         "4.5" = "/5_Star_Rating_System_4_and_a_half_stars.png",
         "5" = "/5_Star_Rating_System_5_stars.png")

  return(as.character(img(src=imgURL, height = 15, width = 85)))
}

starsHTML = function(stars) {
  #print(stars)
  # TODO Fill with the appropiate number of stars, for now it's only one, constant
  sapply(stars, selectImage)
}