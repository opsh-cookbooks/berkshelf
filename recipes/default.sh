#need: gem
which berks &> /dev/null
if [ $? -eq 0 ]
then
  echo.info "berkshelf already installed"
  exit 1
fi

case "${node[os]} ${node[version]}" in
ubuntu*)
  apt-get update && apt-get install -y curl git vim
  ;;
*)
  exit 1
  ;;
esac


case "${node[os]} ${node[version]}" in
ubuntu*12.04*)
    ldconfig -v | grep gecode &> /dev/null
    if [ $? -ne 0 ]; then
      apt-get install -y libgecode30 libgecode-dev
    fi
;;
ubuntu*14.04*)
    ldconfig -v | grep gecode &> /dev/null
    if [ $? -ne 0 ]; then
      apt-get install build-essential
      [ -f "gecode-3.7.3.tar.gz" ] || wget http://www.gecode.org/download/gecode-3.7.3.tar.gz
      tar zxf gecode-3.7.3.tar.gz
      cd gecode-3.7.3 && ./configure && make && make install
      ldconfig
#       template_cp "gecode_3.7.3-1_amd64.deb" /opt/srcv/
#       dpkg -i /opt/srcv/gecode_3.7.3-1_amd64.deb
    fi
;;
esac


USE_SYSTEM_GECODE=1 gem install dep-selector-libgecode --no-ri --no-rdoc
gem install berkshelf --no-ri --no-rdoc 
gem install bundler --no-ri --no-rdoc 
