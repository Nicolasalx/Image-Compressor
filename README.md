# Image Compressor

## Project Description

The Image Compressor project focuses on color reduction in images through clustering techniques. The main task is to implement a k-means clustering algorithm to reduce the number of colors in an image. This project involves reading image data from a file, clustering the colors using k-means, and outputting the clustered colors with their associated pixel positions. The goal is to compress the image by reducing the number of unique colors while preserving the overall appearance of the image.

The image compression process is divided into three steps:
1. **Reading and Extracting Colors:** Read the pixel data from the file and extract the color information.
2. **Color Clustering:** Apply the k-means clustering algorithm to group similar colors together.
3. **Generating Compressed Image:** Index the means of the clusters and create the compressed image (this step is not implemented in this project but is a consideration for future development).

## What is the KMeans

![image](https://github.com/user-attachments/assets/7690d26f-122e-408e-ae76-a6e7823238ae)

K-means clustering is an iterative algorithm used to partition data into clusters. Each cluster is represented by its centroid, and the algorithm works by minimizing the variance within each cluster. In the context of image compression, it helps in grouping similar colors and replacing them with the mean color of the cluster.

## Representation

![image](https://github.com/user-attachments/assets/29e42c4f-c84b-4a97-9cdb-e505e8d721e2)

The clustering process is represented visually by grouping pixel colors into clusters. Each cluster is represented by a centroid color, and all pixels assigned to that cluster are replaced by this centroid color in the compressed output.

## Graphical Interface

![image](https://github.com/user-attachments/assets/c81512de-76b4-47e9-ad10-ebff9ffae35f)

This section illustrates the graphical interface for visualizing the image compression results. It shows how the k-means clustering algorithm is applied to the image data and how the colors are grouped and displayed.

## Rotation of the Image

![image](https://github.com/user-attachments/assets/17b3c780-8248-4aab-9f52-029aebbe367f)

This image demonstrates the rotation of the image for better visualization. Although rotation is not directly related to color clustering, it helps in viewing the effects of the compression algorithm from different angles.

## Convert Image

![image](https://github.com/user-attachments/assets/a8faccb4-6fb1-4eba-85a0-0324aa886d9f)

This section provides an example of converting an image into its compressed form. The conversion process involves applying the k-means algorithm to the pixel colors and generating a compressed version of the image.
