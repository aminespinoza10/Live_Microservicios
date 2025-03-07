#!/bin/bash

cd ..

if [ ! -d "services" ]; then
  mkdir services
else
  echo "Directory 'services' already exists."
fi

cd services || exit

dotnet new webapi -o EndpointService

cd ..