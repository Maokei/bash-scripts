#!/usr/bin/env bash
cvVersion="4.1.1"
cwd=$(pwd)

rm -rf opencv/build
rm -rf opencv_contrib/build

#mkdir -p opencv
#mkdir -p opencv_contrib
#cd opencv 
#wget -c https://github.com/opencv/opencv/archive/4.1.1/opencv-4.1.1.tar.gz
#tar xf opencv-4.1.1.tar.gz
#cd ../opencv_contrib
#wget -c https://github.com/opencv/opencv_contrib/archive/4.1.1/opencv_contrib-4.1.1.tar.gz


compileOpenCv () {
	cd opencv
	mkdir -p build
	cd build
	#time to snuggle
	#-D CMAKE_INSTALL_PREFIX=/usr/local \
	cmake -D CMAKE_BUILD_TYPE=RELEASE \
      -D CMAKE_INSTALL_PREFIX=~/opencv/OpenCV-"$cvVersion" \
      -D INSTALL_C_EXAMPLES=ON \
      -D INSTALL_PYTHON_EXAMPLES=ON \
      -D WITH_TBB=ON \
      -D WITH_V4L=ON \
      -D WITH_QT=ON \
      -D WITH_OPENGL=ON \
      -D OPENCV_PYTHON3_INSTALL_PATH=~/OpenCV-$cvVersion-py3/lib/python3.7/site-packages \
      -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
      -D OPENCV_ENABLE_NONFREE=ON \
      -D BUILD_EXAMPLES=ON ..
	make -j4
	make install
}

cloneOpenCv () {
	git clone https://github.com/opencv/opencv.git
	cd opencv
	git checkout tags/"$cvVersion"
	cd ..
}

cloneOpenCvContrib () {
	git clone https://github.com/opencv/opencv_contrib.git
	cd opencv_contrib
	git checkout tags/"$cvVersion"
	cd ..
}

installDeps () {
	## Install dependencies
	sudo apt -y install build-essential checkinstall cmake pkg-config yasm git
	#sudo apt -y install git gfortran
	sudo apt -y install libjpeg8-dev libpng-dev

	sudo apt -y install software-properties-common
	#sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main"
	sudo apt -y update

	sudo apt -y install libjasper1
	sudo apt -y install libtiff-dev

	sudo apt -y install libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev
	sudo apt -y install libxine2-dev libv4l-dev
	#cd /usr/include/linux
	#sudo ln -s -f ../libv4l1-videodev.h videodev.h
	cd "$cwd"

	sudo apt -y install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev \
	libgtk2.0-dev libtbb-dev qt5-default libatlas-base-dev \
	libfaac-dev libmp3lame-dev libtheora-dev libvorbis-dev libxvidcore-dev \
	libopencore-amrnb-dev libopencore-amrwb-dev libavresample-dev \
	x264 v4l-utils python3-venv

	# Optional dependencies
	sudo apt -y install libprotobuf-dev protobuf-compiler
	sudo apt -y install libgoogle-glog-dev libgflags-dev
	sudo apt -y install libgphoto2-dev libeigen3-dev libhdf5-dev doxygen
	sudo apt -y install tesseract-ocr tesseract-ocr-all
	
	sudo ln -s /usr/include/eigen3/Eigen /usr/include/Eigen
}

installPythonLibs () {
	# create virtual environment
	echo "Python environment"
	echo "OpenCV-$cvVersion-py3"
	python3 -m venv ~/OpenCV-"$cvVersion"-py3
	echo "# Virtual Environment Wrapper" >> ~/.bash_aliases
	#echo "alias workoncv-$cvVersion=\"source $cwd/OpenCV-$cvVersion-py3/bin/activate\"" >> ~/.bash_aliases
	#source "$cwd"/OpenCV-"$cvVersion"-py3/bin/activate
	echo "alias workoncv-$cvVersion=\"source ~/OpenCV-$cvVersion-py3/bin/activate\"" >> ~/.bash_aliases
	source ~/OpenCV-"$cvVersion"-py3/bin/activate

	# now install python libraries within this virtual environment
	pip3 install wheel numpy scipy matplotlib scikit-image scikit-learn ipython

	# quit virtual environment
	deactivate
}

installDeps
cloneOpenCv
cloneOpenCvContrib
installPythonLibs
compileOpenCv
sudo rm /usr/include/Eigen
