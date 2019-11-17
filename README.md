# action-autoscope

Automatically adds a scope in package.json using the repo's owner username for publishing on github package repository.  
This is primary used for easily publish a package to the github package repository while also publishing to the npm package repository without a scope.

Example of usage:

```yaml
name: Publish

on:
  release:
    types: [published]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1
      - uses: actions/setup-node@v1
        with:
          node-version: 12
      - run: yarn install
      - run: npm test

  publish-gpr:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1
      - uses: actions/setup-node@v1
        with:
          node-version: 12
          registry-url: https://npm.pkg.github.com/
          scope: '<@OWNER>'
        env:
          NODE_AUTH_TOKEN: ${{secrets.GITHUB_TOKEN}}
      - name: Dep install
        run: yarn install
      - name: Autoscope package
        uses: khaazz/action-autoscope@master
      - name: Configure .npmrc
        run: echo registry=https://npm.pkg.github.com/<OWNER> >> .npmrc
      - name: Publish
        run: npm publish
        env:
          NODE_AUTH_TOKEN: ${{secrets.GITHUB_TOKEN}}
```
