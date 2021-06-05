#!/usr/bin/env sh
export ANDROID_NDK="$ANDROID_NDK"
export ANDROID_SDK_ROOT="$ANDROID_SDK_ROOT"
export OPENCV_ROOT="$OPENCV_ROOT"

CMAKE_ARGS="-DNATIVE_API_LEVEL=21 \
            -DBUILD_ANDROID_EXAMPLES=0 \
            -DBUILD_ANDROID_PACKAGE=0 \
            -DBUILD_DOCS=0 \
            -DBUILD_EXAMPLES=0 \
            -DBUILD_FAT_JAVA_LIB=0 \
            -DBUILD_JASPER=0 \
            -DBUILD_JPEG=0 \
            -DBUILD_OPENEXR=0 \
            -DBUILD_PACKAGE=0 \
            -DBUILD_PERF_TESTS=0 \
            -DBUILD_PNG=0 \
            -DBUILD_SHARED_LIBS=1 \
            -DBUILD_TBB=0 \
            -DBUILD_TESTS=0 \
            -DBUILD_TIFF=0 \
            -DBUILD_WITH_DEBUG_INFO=0 \
            -DBUILD_ZLIB=0 \
            -DBUILD_opencv_androidcamera=0 \
            -DBUILD_opencv_apps=0 \
            -DBUILD_opencv_calib3d=1 \
            -DBUILD_opencv_contrib=0 \
            -DBUILD_opencv_core=1 \
            -DBUILD_opencv_dnn=0 \
            -DBUILD_opencv_features2d=1 \
            -DBUILD_opencv_flann=1 \
            -DBUILD_opencv_gapi=0 \
            -DBUILD_opencv_gpu=0 \
            -DBUILD_opencv_highgui=0 \
            -DBUILD_opencv_imgcodecs=0 \
            -DBUILD_opencv_imgproc=1 \
            -DBUILD_opencv_java=0 \
            -DBUILD_opencv_legacy=0 \
            -DBUILD_opencv_ml=0 \
            -DBUILD_opencv_nonfree=0 \
            -DBUILD_opencv_objdetect=1 \
            -DBUILD_opencv_ocl=0 \
            -DBUILD_opencv_photo=0 \
            -DBUILD_opencv_stitching=0 \
            -DBUILD_opencv_superres=0 \
            -DBUILD_opencv_ts=0 \
            -DBUILD_opencv_video=0 \
            -DBUILD_opencv_videoio=0 \
            -DBUILD_opencv_videostab=0 \
            -DBUILD_opencv_world=0 \
            -DWITH_CUBLAS=0 \
            -DWITH_CUDA=0 \
            -DWITH_CUFFT=0 \
            -DWITH_EIGEN=0 \
            -DWITH_IPP=0 \
            -DWITH_JASPER=0 \
            -DWITH_JPEG=0 \
            -DWITH_OPENCL=0 \
            -DWITH_OPENEXR=0 \
            -DWITH_OPENMP=0 \
            -DWITH_PNG=0 \
            -DWITH_TBB=0 \
            -DWITH_TIFF=0"

function build_opencv {
  ABI=$1
  echo "ANDROID_NDK $ANDROID_NDK"
  echo "ANDROID_SDK_ROOT $ANDROID_SDK_ROOT"
  echo "OPENCV_ROOT $OPENCV_ROOT"
  pushd $OPENCV_ROOT

  echo "Building Opencv for $ABI"
  mkdir build_$ABI
  pushd build_$ABI

  cmake -DANDROID_ABI=$ABI \
        -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK}/build/cmake/android.toolchain.cmake \
        -DANDROID_NDK=${ANDROID_NDK} \
        -DCMAKE_BUILD_TYPE="Release" \
        -DCMAKE_C_FLAGS="-Os -s" \
        -DCMAKE_CXX_FLAGS="-Os -s" \
        $CMAKE_ARGS ..
  make -j8
  make install

  popd
  popd
}

build_opencv x86_64
build_opencv arm64-v8a

#ANDROID_NDK=~/Library/Android/sdk/ndk/21.4.7075529 ANDROID_SDK_ROOT=~/Library/Android/sdk OPENCV_ROOT=~/Downloads/opencv-4.5.2 ./build_cv.sh
