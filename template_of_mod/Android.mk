LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

# Ito ang magiging pangalan ng mod mo (lalabas na RagdollPhysics.so)
LOCAL_MODULE    := RagdollPhysics

# Dito nakalista ang lahat ng .cpp files na kailangan i-compile
# Siguraduhin na tama ang path ng logger at config
LOCAL_SRC_FILES := main.cpp mod/logger.cpp mod/config.cpp

# Mga settings para sa compiler
LOCAL_CFLAGS    += -O2 -mfloat-abi=softfp -DNDEBUG -std=c++17
LOCAL_C_INCLUDES += ./include

# Importante ito para sa logging sa Android logcat
LOCAL_LDLIBS    += -llog

include $(BUILD_SHARED_LIBRARY)

