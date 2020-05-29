FROM nvidia/driver:local

ARG DEBIAN_FRONTEND=noninteractive

RUN echo 'deb http://security.ubuntu.com/ubuntu xenial-security main' >> /etc/apt/sources.list && \
    echo 'deb http://security.ubuntu.com/ubuntu bionic universe' >> /etc/apt/sources.list && \
    echo 'deb http://security.ubuntu.com/ubuntu bionic-updates universe' >> /etc/apt/sources.list && \
    echo 'deb http://security.ubuntu.com/ubuntu bionic-security universe' >> /etc/apt/sources.list

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    ca-certificates \
    git \
    wget \
    libgtk2.0-dev \
    pkg-config \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    python-dev \
    python-numpy \
    libegl1-mesa-dev \
    libtbb2 \
    libtbb-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev  \
    libjasper-dev \
    libdc1394-22-dev \
    libvtk7-dev \
    libgoogle-glog-dev \
    libatlas-base-dev \
    libeigen3-dev \
    libsuitesparse-dev && \
    rm -rf /var/lib/apt/lists/*

RUN cd /root && \
    git clone https://ceres-solver.googlesource.com/ceres-solver && \
    cd ceres-solver && \
    mkdir build && cd build && \
    cmake .. && \
    make -j $(nproc) && \
    make test && \
    make install && \
    cd .. && rm -rf ceres-solver

RUN cd /root && \
	wget https://github.com/opencv/opencv/archive/3.4.5.tar.gz -O opencv.tar.gz && \
	tar zxf opencv.tar.gz && rm -f opencv.tar.gz && \
	wget https://github.com/opencv/opencv_contrib/archive/3.4.5.tar.gz -O contrib.tar.gz && \
	tar zxf contrib.tar.gz && rm -f contrib.tar.gz && \
	cd opencv-3.4.5 && mkdir build && cd build && \
	cmake -D CMAKE_BUILD_TYPE=RELEASE \
	-D CMAKE_INSTALL_PREFIX=/usr/local \
	-D INSTALL_PYTHON_EXAMPLES=OFF \
	-D OPENCV_EXTRA_MODULES_PATH=/root/opencv_contrib-3.4.5/modules \
	-D BUILD_DOCS=OFF \
	-D BUILD_TESTS=OFF \
	-D BUILD_EXAMPLES=ON \
	-D BUILD_opencv_python2=ON \
	-D BUILD_opencv_python3=ON \
	-D WITH_1394=OFF \
	-D WITH_MATLAB=OFF \
	-D WITH_OPENCL=OFF \
	-D WITH_OPENCLAMDBLAS=OFF \
	-D WITH_OPENCLAMDFFT=OFF \
	-D WITH_GSTREAMER=ON \
	-D WITH_FFMPEG=ON \
    -D WITH_VTK=On \
	-D CMAKE_CXX_FLAGS="-O3 -funsafe-math-optimizations" \
	-D CMAKE_C_FLAGS="-O3 -funsafe-math-optimizations" \
    -D OPENCV_GENERATE_PKGCONFIG=ON \
	.. && make -j $(nproc) && make install && \
    cd /root && rm -rf opencv-3.4.5 opencv_contrib-3.4.5

RUN find / -name "libopencv_sfm.so.3.4*" >> /etc/ld.so.conf.d/opencv.conf && \
    ldconfig -v

WORKDIR /home