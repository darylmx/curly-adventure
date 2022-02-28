#!/usr/bin/env bash

cd /opt
sudo wget https://nodejs.org/dist/v16.13.2/node-v16.13.2-linux-x64.tar.xz
sudo tar xvf node-v16.13.2-linux-x64.tar.xz
sudo cp -iav /opt/node-v16.13.2-linux-x64/bin/node /usr/local/bin/node

sudo git clone https://github.com/bezkoder/vue-js-node-js-express-mysql.git
cd vue-js-node-js-express-mysql

sudo sed -i 's#localhost#${DB_HOSTNAME}#' app/config/db.config.js
sudo sed -i 's#testdb#${DB_NAME}#' app/config/db.config.js
sudo sed -i 's#root#${DB_USERNAME}#' app/config/db.config.js
sudo sed -i 's#123456#${DB_PASSWORD}#' app/config/db.config.js

sudo sed -i 's#http://localhost:8081#\*#' server.js
sudo sed -i 's#localhost#${ELB_HOSTNAME}#' app/config/db.config.js
sudo sed -i 's#localhost:8080#${ELB_HOSTNAME}#' app/views/js/chunk-1b8a9a30.37814895.js
sudo sed -i 's#localhost:8080#${ELB_HOSTNAME}#' app/views/js/chunk-1b8a9a30.37814895.js.map

sudo /opt/node-v16.13.2-linux-x64/bin/npm install
sudo node server.js > node.log