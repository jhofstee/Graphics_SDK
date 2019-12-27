RN 4 09 00 01 

RN 4 09 00 01 


Release Notes for release 4.09.00.01 

Introduction 

This release includes the Linux graphics drivers for the SGX530 family of chipsets AM35x/37xx, AM335x, 
387x(TI814x)/389x(TI816x).The Graphics SDK contains documentation, demo programs and tools. 

Validation information 
NOTE 


1. This release has been tested on AM parts only. 
2. This release is build tested only for 387x(TI814x) & 389x(TI816x) & DM parts. 
3. This release is build tested only against 3.8 kernel. 
Installation and Usage 

Please look for detailed installation and usage instructions at below linkhttp://
processors.wiki.ti.com/index.php/Graphics_SDK_Quick_installation_and_user_guide 

Features in this release 

• NEW - Runtime PM support for AM335x (selectable via command line during build(make)) 
• NEW - PowerVR SDK 3.0 (integrated including training course examples). 
• NEW - Support for compilation against 3.8 kernel. 
• Based on the IMG Linux 1.9 DDK (1.9ED2188537) 
• Supports Xorg X Server 1.12 
Pre-requisites 

Kernel(Linux PSP) versions supported or used for validation 

Please note that this release has been tested only on AM devices. No testing has been done on the DM parts. Only 
the following devices have been tested & details below 


• AM335x - 3.2 kernel - http://arago-project.org/git/projects/linux-am33x.git 
• AM335x Linux PSP 04.06.00.10 
• Branch – v3.2-staging, TAG - v3.2_AM335xPSP_04.06.00.10-rc1, commit id 
-c8cce6279f5c126cbf6b6054f1ea0148bfc19511 
• AM35xx/AM37xx - 2.6.37 kernel 
• Linux PSP Release : 04.02.00.07. 
• Display drivers with DSS2 support ie, CONFIG_OMAP2_DSS=y 

RN 4 09 00 01 

Toolchain 

• Arago Dynamic toolchain based on GCC 4.5.3 for all devices (supplied with AMSDK releases). 
• Linaro 4.6.3 hardfp toolchain(arm-linux-gnueabihf-) was used for creating the hardfp package. 
What is supported 

Khronos API support 

• OpenGL ES 1.1 
• OpenGL ES 2.0 
• EGL 
• Limited 2D acceleration via PVR2D API 
Window Systems 

The following Window Systems are supported, on Linux: 

• Null Window System (with Pixmap support) 
• X11 support(DRI/DRM Xorg driver) 
Buffer Swap modes 

The following modes of buffer swapping are supported, 

• Front (1 buffer), Flip (chained buffers) 
Selection of these modes is done via entries in /etc/powervr.ini. Please refer to http:/ / processors. wiki. ti. com/ 
index.php/SGXDbg#WindowSystem 

Extensions 

• IMG propreitary Bufferclass texture streaming enabled by default. 
• eglimage is supported & can be enabled by passing EGLIMAGE=1 during make install. 
What is not supported 

• Power Management features are not fully validated. Active power management support available on 
OMAP35x/37x platforms only. 
• Kernel (for OMAP35x/AM35x/37xx) configured without DSS2 framework support will not work with the current 
display class driver. 
• PIXMAP - Fbdev dependancy removal is not supported in FLIP buffer swapping mode. 
• X11 window system has been validated with the Xorg file system available as part of the graphics SDK 
installation(targetfs/XSGX folder) using demos, apps built with Xorg support. This has not been validated with 
window managers. 
• Xorg DRI driver supports full screen mode with vsync synchronization without VRFB only on 
OMAP35xx/AM35xx/37xx devices. Also the Xorg DRI driver supports Vsync synchronization in full screen 
mode only on all devices. 
• Debug build is meant for debug/testing purposes only & should not be used for measuring performance. 

RN 4 09 00 01 3 
Additional Packages 
Demonstration packages for Texture streaming extension are available at the below link, 
• OpenGLES_Texture_Streaming_-_bc-cat_User_Guide 
Benchmarking packages for SGX functionalities and APIs are available at, 
• https:/ / gforge. ti. com/ gf/ project/ gleslayer/ 
GPU Compositing solution at, 
• http:/ / processors. wiki. ti. com/ index. php/ GPU_Compositing 
Multi channel video streaming solution at, 
• https:/ / github. com/ aditya-nellutla/ TI-Graphics-Accelerated-Video-streaming- 
Debugging SGX driver related issues 
For debugging issues with SGX driver and frequently asked questions, please go through 
http:/ / processors. wiki. ti. com/ index. php/ SGXDbg 
Fixed in this Release 
• None 
Limitations/ Known Issues 
• [SDOCM00061522] FrontEGL mode of swapping buffers may show artifacts (ex, lines at the top), when 
operating with DVI output. 
• [SDOCM00061276] Texturing via glTexImage2D will result in CPU utilisation depending on size of 
texture.Using OpenVG will result in CPU utilisation depending on complexity of Vector Graphics operations. 
• [SDOCM00085674] Lock related warnings seen with 2.6.37 kernel (Linux PSP 04.02.00.07) on 
OMAP35x/AM35xx/37xx platforms. Please refer to sgxdbg page - http:/ / processors. wiki. ti. com/ index. php/ 
SGXDbg#Lock_related_warnings_seen_on_OMAP35x. 2FAM35x. 2F37xx_with_2. 6. 37_kernel for more 
details. 
• [SDOCM00063807] All SDK demos should be exited by pressing 'q'. Ctrl-C can result in unknown behaviour 
after the closure. 
• [SDOCM00068272],[SDOCM00068322] Blue line on top of DVI display for PolyBump demo, thin line on top 
for sgx_render_flip_test demo 
• hardfp package has been only build tested. (NOTE-To use this package, all dependant components must be built 
with hard float option (-mfloat-abi=hard)) 
Contents 
The folders in the installed package contain binaries for several family of devices containing the SGX530 core. Brief 
description of these folders is below.

RN 4 09 00 01 

Graphics SDK folder contents 


Folder Name Description Used by 
2 gfx_dbg_es3.x / 
gfx_rel_es3.x 
Debug/Release binaries for platforms having SGX 
core revision 1.2.1 
(AM35xx) How to check? 
3 gfx_dbg_es5.x / 
gfx_rel_es5.x 
Debug/Release binaries for platforms having SGX 
core revision 1.2.5 
(AM37xx) How to check? 
4 gfx_dbg_es6.x / 
gfx_rel_es6.x 
Debug/Release binaries for 38xx(387x,389x) devices 
(SGX core revision 1.2.5) 
38xx How to check? 
4 gfx_dbg_es8.x / 
gfx_rel_es8.x 
Debug/Release binaries for 335x devices (SGX core 
revision 1.2.5) 
AM335x EVM 
5 GFX_Linux_KM Source for Graphics Kernel Modules Contains kernel dependent code, changes depending on Linux 
kernel used 
6 GFX_Linux_SDK Demos, Training courses, PVR Tools,classes and 
header files 
Used for building new applications (Available only in the SDK 
package, not in the BIN package) 
7 include Contains updated header file for GL extensions, 
specifically the buffer class streaming extension 
Useful for video texturing applications involving bufferclass 
driver 
8 tools Contains devmem2, and other packages Useful for running/debugging/benchmarking of Graphics SDK 


Article Sources and Contributors 

Article Sources and Contributors 


RN 4 09 00 01 Source: http://processors.wiki.ti.com/index.php?oldid=136812 Contributors: Prathap 

License 

THE WORK (AS DEFINED BELOW) IS PROVIDED UNDER THE TERMS OF THIS CREATIVE COMMONS PUBLIC LICENSE ("CCPL" OR "LICENSE"). THE WORK IS PROTECTED BY COPYRIGHT AND/OR OTHER
APPLICABLE LAW. ANY USE OF THE WORK OTHER THAN AS AUTHORIZED UNDER THIS LICENSE OR COPYRIGHT LAW IS PROHIBITED. 
BY EXERCISING ANY RIGHTS TO THE WORK PROVIDED HERE, YOU ACCEPT AND AGREE TO BE BOUND BY THE TERMS OF THIS LICENSE. TO THE EXTENT THIS LICENSE MAY BE CONSIDERED TO BE
A CONTRACT, THE LICENSOR GRANTS YOU THE RIGHTS CONTAINED HERE IN CONSIDERATION OF YOUR ACCEPTANCE OF SUCH TERMS AND CONDITIONS. 


License 

1. Definitions 
a. "Adaptation" means a work based upon the Work, or upon the Work and other pre-existing works, such as a translation, adaptation, derivative work, arrangement of music or other alterations of a literary or artistic work, orphonogram or performance and includes cinematographic adaptations or any other form in which the Work may be recast, transformed, or adapted including in any form recognizably derived from the original, except that a workthat constitutes a Collection will not be considered an Adaptation for the purpose of this License. For the avoidance of doubt, where the Work is a musical work, performance or phonogram, the synchronization of the Work intimed-relation with a moving image ("synching") will be considered an Adaptation for the purpose of this License.
b. "Collection" means a collection of literary or artistic works, such as encyclopedias and anthologies, or performances, phonograms or broadcasts, or other works or subject matter other than works listed in Section 1(f) below,
which, by reason of the selection and arrangement of their contents, constitute intellectual creations, in which the Work is included in its entirety in unmodified form along with one or more other contributions, each constitutingseparate and independent works in themselves, which together are assembled into a collective whole. A work that constitutes a Collection will not be considered an Adaptation (as defined below) for the purposes of this License. 
c. "Creative Commons Compatible License" means a license that is listed at http:/ / creativecommons. org/ compatiblelicenses that has been approved by Creative Commons as being essentially equivalent to this License,
including, at a minimum, because that license: (i) contains terms that have the same purpose, meaning and effect as the License Elements of this License; and, (ii) explicitly permits the relicensing of adaptations of works madeavailable under that license under this License or a Creative Commons jurisdiction license with the same License Elements as this License.
d. "Distribute" means to make available to the public the original and copies of the Work or Adaptation, as appropriate, through sale or other transfer of ownership.
e. "License Elements" means the following high-level license attributes as selected by Licensor and indicated in the title of this License: Attribution, ShareAlike.
f. "Licensor" means the individual, individuals, entity or entities that offer(s) the Work under the terms of this License. 
g. "Original Author" means, in the case of a literary or artistic work, the individual, individuals, entity or entities who created the Work or if no individual or entity can be identified, the publisher; and in addition (i) in the case of aperformance the actors, singers, musicians, dancers, and other persons who act, sing, deliver, declaim, play in, interpret or otherwise perform literary or artistic works or expressions of folklore; (ii) in the case of a phonogram theproducer being the person or legal entity who first fixes the sounds of a performance or other sounds; and, (iii) in the case of broadcasts, the organization that transmits the broadcast.
h. "Work" means the literary and/or artistic work offered under the terms of this License including without limitation any production in the literary, scientific and artistic domain, whatever may be the mode or form of its expressionincluding digital form, such as a book, pamphlet and other writing; a lecture, address, sermon or other work of the same nature; a dramatic or dramatico-musical work; a choreographic work or entertainment in dumb show; amusical composition with or without words; a cinematographic work to which are assimilated works expressed by a process analogous to cinematography; a work of drawing, painting, architecture, sculpture, engraving orlithography; a photographic work to which are assimilated works expressed by a process analogous to photography; a work of applied art; an illustration, map, plan, sketch or three-dimensional work relative to geography,
topography, architecture or science; a performance; a broadcast; a phonogram; a compilation of data to the extent it is protected as a copyrightable work; or a work performed by a variety or circus performer to the extent it is nototherwise considered a literary or artistic work.
i. "You" means an individual or entity exercising rights under this License who has not previously violated the terms of this License with respect to the Work, or who has received express permission from the Licensor to exerciserights under this License despite a previous violation.
j. "Publicly Perform" means to perform public recitations of the Work and to communicate to the public those public recitations, by any means or process, including by wire or wireless means or public digital performances; tomake available to the public Works in such a way that members of the public may access these Works from a place and at a place individually chosen by them; to perform the Work to the public by any means or process and thecommunication to the public of the performances of the Work, including by public digital performance; to broadcast and rebroadcast the Work by any means including signs, sounds or images.
k. "Reproduce" means to make copies of the Work by any means including without limitation by sound or visual recordings and the right of fixation and reproducing fixations of the Work, including storage of a protectedperformance or phonogram in digital form or other electronic medium. 
2. Fair Dealing Rights
Nothing in this License is intended to reduce, limit, or restrict any uses free from copyright or rights arising from limitations or exceptions that are provided for in connection with the copyright protection under copyright law or otherapplicable laws. 

3. License Grant 
Subject to the terms and conditions of this License, Licensor hereby grants You a worldwide, royalty-free, non-exclusive, perpetual (for the duration of the applicable copyright) license to exercise the rights in the Work as statedbelow: 

a. to Reproduce the Work, to incorporate the Work into one or more Collections, and to Reproduce the Work as incorporated in the Collections;
b. to create and Reproduce Adaptations provided that any such Adaptation, including any translation in any medium, takes reasonable steps to clearly label, demarcate or otherwise identify that changes were made to the originalWork. For example, a translation could be marked "The original work was translated from English to Spanish," or a modification could indicate "The original work has been modified."; 
c. to Distribute and Publicly Perform the Work including as incorporated in Collections; and,
d. to Distribute and Publicly Perform Adaptations.
e. For the avoidance of doubt: 
i. Non-waivable Compulsory License Schemes. In those jurisdictions in which the right to collect royalties through any statutory or compulsory licensing scheme cannot be waived, the Licensor reserves the exclusive rightto collect such royalties for any exercise by You of the rights granted under this License;
ii. Waivable Compulsory License Schemes. In those jurisdictions in which the right to collect royalties through any statutory or compulsory licensing scheme can be waived, the Licensor waives the exclusive right to collectsuch royalties for any exercise by You of the rights granted under this License; and,
iii. Voluntary License Schemes. The Licensor waives the right to collect royalties, whether individually or, in the event that the Licensor is a member of a collecting society that administers voluntary licensing schemes, via
that society, from any exercise by You of the rights granted under this License.
The above rights may be exercised in all media and formats whether now known or hereafter devised. The above rights include the right to make such modifications as are technically necessary to exercise the rights in other media andformats. Subject to Section 8(f), all rights not expressly granted by Licensor are hereby reserved. 

4. Restrictions 
The license granted in Section 3 above is expressly made subject to and limited by the following restrictions: 

a. You may Distribute or Publicly Perform the Work only under the terms of this License. You must include a copy of, or the Uniform Resource Identifier (URI) for, this License with every copy of the Work You Distribute orPublicly Perform. You may not offer or impose any terms on the Work that restrict the terms of this License or the ability of the recipient of the Work to exercise the rights granted to that recipient under the terms of the License.
You may not sublicense the Work. You must keep intact all notices that refer to this License and to the disclaimer of warranties with every copy of the Work You Distribute or Publicly Perform. When You Distribute or PubliclyPerform the Work, You may not impose any effective technological measures on the Work that restrict the ability of a recipient of the Work from You to exercise the rights granted to that recipient under the terms of the License.
This Section 4(a) applies to the Work as incorporated in a Collection, but this does not require the Collection apart from the Work itself to be made subject to the terms of this License. If You create a Collection, upon notice fromany Licensor You must, to the extent practicable, remove from the Collection any credit as required by Section 4(c), as requested. If You create an Adaptation, upon notice from any Licensor You must, to the extent practicable,
remove from the Adaptation any credit as required by Section 4(c), as requested.
b. You may Distribute or Publicly Perform an Adaptation only under the terms of: (i) this License; (ii) a later version of this License with the same License Elements as this License; (iii) a Creative Commons jurisdiction license(either this or a later license version) that contains the same License Elements as this License (e.g., Attribution-ShareAlike 3.0 US)); (iv) a Creative Commons Compatible License. If you license the Adaptation under one of thelicenses mentioned in (iv), you must comply with the terms of that license. If you license the Adaptation under the terms of any of the licenses mentioned in (i), (ii) or (iii) (the "Applicable License"), you must comply with theterms of the Applicable License generally and the following provisions: (I) You must include a copy of, or the URI for, the Applicable License with every copy of each Adaptation You Distribute or Publicly Perform; (II) Youmay not offer or impose any terms on the Adaptation that restrict the terms of the Applicable License or the ability of the recipient of the Adaptation to exercise the rights granted to that recipient under the terms of the ApplicableLicense; (III) You must keep intact all notices that refer to the Applicable License and to the disclaimer of warranties with every copy of the Work as included in the Adaptation You Distribute or Publicly Perform; (IV) whenYou Distribute or Publicly Perform the Adaptation, You may not impose any effective technological measures on the Adaptation that restrict the ability of a recipient of the Adaptation from You to exercise the rights granted tothat recipient under the terms of the Applicable License. This Section 4(b) applies to the Adaptation as incorporated in a Collection, but this does not require the Collection apart from the Adaptation itself to be made subject tothe terms of the Applicable License. 
c. If You Distribute, or Publicly Perform the Work or any Adaptations or Collections, You must, unless a request has been made pursuant to Section 4(a), keep intact all copyright notices for the Work and provide, reasonable to themedium or means You are utilizing: (i) the name of the Original Author (or pseudonym, if applicable) if supplied, and/or if the Original Author and/or Licensor designate another party or parties (e.g., a sponsor institute,
publishing entity, journal) for attribution ("Attribution Parties") in Licensor's copyright notice, terms of service or by other reasonable means, the name of such party or parties; (ii) the title of the Work if supplied; (iii) to theextent reasonably practicable, the URI, if any, that Licensor specifies to be associated with the Work, unless such URI does not refer to the copyright notice or licensing information for the Work; and (iv) , consistent withSsection 3(b), in the case of an Adaptation, a credit identifying the use of the Work in the Adaptation (e.g., "French translation of the Work by Original Author," or "Screenplay based on original Work by Original Author"). Thecredit required by this Section 4(c) may be implemented in any reasonable manner; provided, however, that in the case of a Adaptation or Collection, at a minimum such credit will appear, if a credit for all contributing authors ofthe Adaptation or Collection appears, then as part of these credits and in a manner at least as prominent as the credits for the other contributing authors. For the avoidance of doubt, You may only use the credit required by thisSection for the purpose of attribution in the manner set out above and, by exercising Your rights under this License, You may not implicitly or explicitly assert or imply any connection with, sponsorship or endorsement by theOriginal Author, Licensor and/or Attribution Parties, as appropriate, of You or Your use of the Work, without the separate, express prior written permission of the Original Author, Licensor and/or Attribution Parties.
d. Except as otherwise agreed in writing by the Licensor or as may be otherwise permitted by applicable law, if You Reproduce, Distribute or Publicly Perform the Work either by itself or as part of any Adaptations or Collections,
You must not distort, mutilate, modify or take other derogatory action in relation to the Work which would be prejudicial to the Original Author's honor or reputation. Licensor agrees that in those jurisdictions (e.g. Japan), inwhich any exercise of the right granted in Section 3(b) of this License (the right to make Adaptations) would be deemed to be a distortion, mutilation, modification or other derogatory action prejudicial to the Original Author'shonor and reputation, the Licensor will waive or not assert, as appropriate, this Section, to the fullest extent permitted by the applicable national law, to enable You to reasonably exercise Your right under Section 3(b) of thisLicense (right to make Adaptations) but not otherwise. 
5. Representations, Warranties and Disclaimer
UNLESS OTHERWISE MUTUALLY AGREED TO BY THE PARTIES IN WRITING, LICENSOR OFFERS THE WORK AS-IS AND MAKES NO REPRESENTATIONS OR WARRANTIES OF ANY KIND CONCERNINGTHE WORK, EXPRESS, IMPLIED, STATUTORY OR OTHERWISE, INCLUDING, WITHOUT LIMITATION, WARRANTIES OF TITLE, MERCHANTIBILITY, FITNESS FOR A PARTICULAR PURPOSE,
NONINFRINGEMENT, OR THE ABSENCE OF LATENT OR OTHER DEFECTS, ACCURACY, OR THE PRESENCE OF ABSENCE OF ERRORS, WHETHER OR NOT DISCOVERABLE. SOME JURISDICTIONS DO NOTALLOW THE EXCLUSION OF IMPLIED WARRANTIES, SO SUCH EXCLUSION MAY NOT APPLY TO YOU. 

6. Limitation on Liability
EXCEPT TO THE EXTENT REQUIRED BY APPLICABLE LAW, IN NO EVENT WILL LICENSOR BE LIABLE TO YOU ON ANY LEGAL THEORY FOR ANY SPECIAL, INCIDENTAL, CONSEQUENTIAL, PUNITIVEOR EXEMPLARY DAMAGES ARISING OUT OF THIS LICENSE OR THE USE OF THE WORK, EVEN IF LICENSOR HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. 

7. Termination 
a. This License and the rights granted hereunder will terminate automatically upon any breach by You of the terms of this License. Individuals or entities who have received Adaptations or Collections from You under this License,
however, will not have their licenses terminated provided such individuals or entities remain in full compliance with those licenses. Sections 1, 2, 5, 6, 7, and 8 will survive any termination of this License.
b. Subject to the above terms and conditions, the license granted here is perpetual (for the duration of the applicable copyright in the Work). Notwithstanding the above, Licensor reserves the right to release the Work under differentlicense terms or to stop distributing the Work at any time; provided, however that any such election will not serve to withdraw this License (or any other license that has been, or is required to be, granted under the terms of thisLicense), and this License will continue in full force and effect unless terminated as stated above. 
8. Miscellaneous 
a. Each time You Distribute or Publicly Perform the Work or a Collection, the Licensor offers to the recipient a license to the Work on the same terms and conditions as the license granted to You under this License.
b. Each time You Distribute or Publicly Perform an Adaptation, Licensor offers to the recipient a license to the original Work on the same terms and conditions as the license granted to You under this License. 
c. If any provision of this License is invalid or unenforceable under applicable law, it shall not affect the validity or enforceability of the remainder of the terms of this License, and without further action by the parties to thisagreement, such provision shall be reformed to the minimum extent necessary to make such provision valid and enforceable.
d. No term or provision of this License shall be deemed waived and no breach consented to unless such waiver or consent shall be in writing and signed by the party to be charged with such waiver or consent. 
e. This License constitutes the entire agreement between the parties with respect to the Work licensed here. There are no understandings, agreements or representations with respect to the Work not specified here. Licensor shall notbe bound by any additional provisions that may appear in any communication from You. This License may not be modified without the mutual written agreement of the Licensor and You.
f. The rights granted under, and the subject matter referenced, in this License were drafted utilizing the terminology of the Berne Convention for the Protection of Literary and Artistic Works (as amended on September 28, 1979),
the Rome Convention of 1961, the WIPO Copyright Treaty of 1996, the WIPO Performances and Phonograms Treaty of 1996 and the Universal Copyright Convention (as revised on July 24, 1971). These rights and subject 

License 

matter take effect in the relevant jurisdiction in which the License terms are sought to be enforced according to the corresponding provisions of the implementation of those treaty provisions in the applicable national law. If thestandard suite of rights granted under applicable copyright law includes additional rights not granted under this License, such additional rights are deemed to be included in the License; this License is not intended to restrict thelicense of any rights under applicable law. 


