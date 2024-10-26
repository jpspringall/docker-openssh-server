$DateString = Get-Date -format "yyyy-MM-dd"
docker build -t jpspringall/ubuntu-openssh-server --build-arg BUILD_DATE=$DateString --push .