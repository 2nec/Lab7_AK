ifneq ($(KERNELRELEASE),)
# kbuild part of makefile
obj-m := hello1.o
ccflags-y += -g # add debugging info
else
# normal makefile
KDIR ?= /lib/modules/`uname -r`/build

default:
	$(MAKE) -C $(KDIR) M=$$PWD
	cp hello1.ko hello1.ko.unstripped
	$(CROSS_COMPILE)strip -g hello1.ko # strip only debugging info
clean:
	$(MAKE) -C $(KDIR) M=$$PWD clean
%.s %.i: %.c # just use make hello1.s instead of objdump
	$(MAKE) -C $(KDIR) M=$$PWD $@
endif