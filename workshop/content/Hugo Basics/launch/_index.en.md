+++
title = "Launch"
chapter = true
weight = 40
pre = "<b>4. </b>"
+++

Follow these steps to launch your workshop for others to use! 

### Launching Site on Github via Environments

Here we show how you use Github to automatically build/deploy this site on Github Pushes and Merges

#### Step 1

Create an actions file if one doesn't exist

```bash
touch .github/workflows/docs.yaml
```
#### Step 2

Change the two parameters in the ```config.toml``` to match desired github repo. 
* The repo name needs to match the hugo project name
If we wanted to rename it we need to change both.

```yaml
baseurl = "https://jonahjon.github.io/Workshop-Scaffolding"

title = "Workshop-Scaffolding"
```

#### Step 3

Assuming you have, or know how to create a github API key go do that through the developer settings.

Name it ```ACTIONS_DEPLOY_KEY```

#### Step 4

Finish by adding in our github actions workflow. This will deploy the site on git pushes, and can be found in the "Environments" section under the repo.

```yaml
name: Publish EKS Accelerator

on:
  push:
    branches: [ master ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1
      - name: Checkout
        uses: actions/setup-node@v1
        with:
          node-version: 10.x
      - name: Setup Hugo
        uses: peaceiris/actions-hugo@v2.2.1
        with:
          hugo-version: '0.58.3'
      - name: Prepare Hugo
        run: |
          git submodule sync && git submodule update --init
      - name: Build
        run: make docs
      - name: add nojekyll
        run: touch ./ps-eks-accelerator/public/.nojekyll
      - name: Deploy
        uses: peaceiris/actions-gh-pages@v3
        with:
          publish_dir: ./ps-eks-accelerator/public  # default: public
          github_token: ${{ secrets.GITHUB_TOKEN }}
```
