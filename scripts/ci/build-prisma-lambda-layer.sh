#!/bin/bash
function build_prisma_lambda_layer() {
  echo "Cleaning up workspace ..."
  rm -rf lambda-layers-prisma-client

  echo "Remove prismaDevDependencies"
  rm node_modules/@prisma/engines/introspection-engine-debian*
  rm node_modules/@prisma/engines/libquery_engine-debian*
  rm node_modules/@prisma/engines/migration-engine-debian*
  rm node_modules/@prisma/engines/prisma-fmt-debian*
R

  echo "Creating layer ..."
  mkdir -p lambda-layers-prisma-client/nodejs/node_modules/.prisma
  mkdir -p lambda-layers-prisma-client/nodejs/node_modules/@prisma

  echo "Prepare Prisma Client lambda layer ..."
  cp -r node_modules/.prisma/client lambda-layers-prisma-client/nodejs/node_modules/.prisma
  cp -r node_modules/@prisma lambda-layers-prisma-client/nodejs/node_modules

  echo "Remove Prisma CLI..."
  rm -rf lambda-layers-prisma-client/nodejs/node_modules/@prisma/cli

  echo "Compressing ..."
  pushd lambda-layers-prisma-client && tar -zcf /tmp/nodejs.tar.gz . && mv /tmp/nodejs.tar.gz ./nodejs.tar.gz

  echo "Remove unzipped files ..."
  rm -rf nodejs

  echo "Stats:"
  ls -lh nodejs.tar.gz

  return 0
}

build_prisma_lambda_layer