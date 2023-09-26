# KitCat

This app displays images to a user along with a list of classifications of what the computer thinks the images are. A progress bar which shows how likely each classification is and a button that lets the user cycle through the images are provided in the app. The goal is to use Machine Learning to classify the images. 

The images to be classified are fetched from an API. The app has employed a custom image classifier as well as a pre-trained model to make the classifications. 
The steps involved into developing this app were:

  - Hit an image API to fetch images for classification
  - Parse the JSON response
  - Import an exisiting CoreML model
  - Classification of images
  - Creation and use of a custom CoreML model
  - Classification of images
  - App styling to make the app visually more appealing

The accuracy is better when the app uses the custom CoreML model beacuse the training sample size of the custom model is much smaller compared to the pre-trained coreML model. The pre-trained model will perform better if there is a more diverse set of images. 

The training data set contained ~1000 labeled images of cats and dogs and 20% (~200 images) of the training data was used for the testing purposes. 
