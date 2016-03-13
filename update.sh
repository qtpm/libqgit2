#!/bin/sh

#if [ ! -e libqgit2 ]; then
#    git clone git@github.com:KDE/libqgit2.git
#else 
#    pushd libqgit2
#    git pull
#    popd
#fi

export LANG=C

echo "copying src"
rm -rf src
mkdir src
cp -r libqgit2/src ./src/qgit2
cp libqgit2/qgit2.h src/
echo "copying tests"
rm -rf test
mkdir test
cp -r libqgit2/tests/TestHelpers.* test
cp libqgit2/tests/Init.cpp test/init_test.cpp
sed -i -e 's/Init\.moc/init_test\.moc/g' test/init_test.cpp
cp libqgit2/tests/Clone.cpp test/clone_test.cpp
sed -i -e 's/Clone\.moc/clone_test\.moc/g' test/clone_test.cpp
cp libqgit2/tests/Checkout.cpp test/checkout_test.cpp
sed -i -e 's/Checkout\.moc/checkout_test\.moc/g' test/checkout_test.cpp
cp libqgit2/tests/Diff.cpp test/diff_test.cpp
sed -i -e 's/Diff\.moc/diff_test\.moc/g' test/diff_test.cpp
cp libqgit2/tests/Repository.cpp test/repository_test.cpp
sed -i -e 's/Repository\.moc/repository_test\.moc/g' test/repository_test.cpp
