#title run
export REDC_START_DIR=`pwd`
export GDX_LIBS_DIR=$REDC_START_DIR/libs
jruby -J-XstartOnFirstThread --debug src/desktop.rb
