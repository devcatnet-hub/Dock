[COMMAND]:      image.make
[PACKAGE]:      IMAGE
[USE]:          dock -image make

[OUT]:          Build Image based in the dockerfile of the current Container folder.

[ACTIONS]:      docker build -f ./DFL/Dockerfile -t deathwalker66/$IMAGE_NAME . --no-cache 

[NOTES]:        More information available in the image.sh script.
