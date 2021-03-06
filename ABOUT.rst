.. SPDX-License-Identifier: CC-BY-SA-4.0

.. section-begin-libcamera

===========
 libcamera
===========

**A complex camera support library for Linux, Android, and ChromeOS**

Cameras are complex devices that need heavy hardware image processing
operations. Control of the processing is based on advanced algorithms that must
run on a programmable processor. This has traditionally been implemented in a
dedicated MCU in the camera, but in embedded devices algorithms have been moved
to the main CPU to save cost. Blurring the boundary between camera devices and
Linux often left the user with no other option than a vendor-specific
closed-source solution.

To address this problem the Linux media community is collaborating with the
industry to develop a camera stack that is open-source-friendly while still
protecting vendor core IP. libcamera was born out of that collaboration and
offers modern camera support to Linux-based systems, including traditional
Linux distributions, ChromeOS and Android.

.. section-end-libcamera
.. section-begin-getting-started
