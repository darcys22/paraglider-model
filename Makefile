dotgit=$(shell ls -d .git/config)
ifneq ($(dotgit), .git/config)
  USE_SINGLE_BUILDDIR=1
endif

subbuilddir:=$(shell echo  `uname | sed -e 's|[:/\\ \(\)]|_|g'`/`git branch | grep '\* ' | cut -f2- -d' '| sed -e 's|[:/\\ \(\)]|_|g'`)
ifeq ($(USE_SINGLE_BUILDDIR),)
  builddir := build/"$(subbuilddir)"
  topdir   := ../../../..
  deldirs  := $(builddir)
else
  builddir := build
  topdir   := ../..
  deldirs  := $(builddir)/debug $(builddir)/release $(builddir)/fuzz
endif

all: release-all

release-all:
	mkdir -p $(builddir)/release
	cd $(builddir)/release && cmake -D BUILD_TESTS=ON -D CMAKE_BUILD_TYPE=release -D WARNINGS_AS_ERRORS=ON $(topdir) && $(MAKE)
