.. section-start-faq

Frequently Asked Questions
--------------------------

What is libcamera?
  libcamera is an open source camera stack for many platforms with a core
  userspace library, and support from the Linux kernel APIs and drivers already
  in place. It aims to control the complexity of embedded camera hardware by
  providing an intuitive API and method of separating untrusted vendor code
  from the open source core.

  libcamera aims to encourage the development of new embedded camera
  applications by limiting the complexity that developers have to deal with.
  The interface is designed around the way that modern embedded camera hardware
  works.


What is the correct way to display the name 'libcamera'?
  libcamera, is always in lowercase. In titles, or at the beginning of
  sentences.


How is libcamera different from V4L2?
  We see libcamera as a continuation of V4L2. One that can more easily handle
  the recent advances in hardware design. As embedded cameras have developed,
  all of the complexity has been pushed on to the developers. With libcamera,
  all of that complexity is simplified and a single model is presented to
  application developers.


Does this mean the camera stack is completely open?
  libcamera is open-source friendly which means all of libcamera itself is open
  source. libcamera uses a plugin system for Image Processing Algorithms (IPA)
  which are built as dynamically-linked shared objects, and are loaded at
  run-time. Open-source modules are identified based on digital signatures,
  while closed-source modules are isolated inside a Sandbox environment with
  restricted access to the system, reducing the impact of untrusted binary
  blobs.
 

libcamera has been described as “the MESA of the camera stack”. What does that mean?
  Mesa provides powerful high-level APIs to applications and implements
  device-specific code in userspace to support the implementation. libcamera
  provides high-level APIs that handle device-specific code in userspace to
  simplify development for application developers.


Which cameras SoCs (pipeline-handlers) are supported?
  Currently supported platforms include the Intel IPU3, RockChip RK3399, UVC,
  as well as pipeline-handler support for the VIMC Kernel test drivers.


What role does the Pipeline Handler play?
  The Pipeline Handlers are used for managing any device specific code for a
  given platform. A 'Simple Pipeline Handler' is under development which will
  support a range of simplistic platforms with a common generic handler.


Which camera protocols are supported?
  libcamera supports cameras that use MIPI CSI-2 protocols.


Can I use libcamera to access photos on digital cameras?
  No, libcamera is a library for controlling embedded camera hardware, it’s not
  an application for accessing photos and has no relationship to gphoto2.
  libcamera supports internal cameras designed for point-and-shoot still image
  and video capture and external UVC cameras designed for video conferencing.


Can libcamera handle multiple cameras simultaneously?
  libcamera can support multiple cameras within a system, but allows only a
  single application to consume the streams from a camera. An application must
  ‘acquire’ a Camera to start operations on it, and should release it when
  finished. Logical cameras where multiple cameras are treated as a single
  camera is a pipeline and hardware specific extension that will be supported
  in the future.


Does libcamera do format conversion and debayering?
  Format conversion and debayering operations are dependent upon the Image
  Signal Processor (ISP) and hardware available. Our demonstration application,
  QCam, does basic software format conversions to handle display but we aim to
  move to using OpenGL to improve real time conversion performance. Where
  possible, QCam will request formats that can be displayed natively without
  requiring software conversions.

.. section-end-faq
