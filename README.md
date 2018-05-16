## Local development

Before you are able to run this locally you need to have [YARN](https://yarnpkg.com/lang/en/docs/install/) and [Hugo installed](https://gohugo.io/getting-started/installing/) on your machine. If you already have Hugo installed, make sure you [have the latest version](https://gohugo.io/getting-started/installing/#upgrade-hugo).

1. Install project dependencies
   ```bash
   make install
   ```

1. Back in the root of the project, run
   ```bash
   make build
   ```

1. And then run the project
   ```bash
   make serve
   ```

1. In your browser navigate to `localhost:1313` to view the project.

### Staging vs Prod

Help center can be built for either staging or prod via:

#### Prod
```bash
 make build
```

```bash
 make serve
```

#### Staging
```bash
 make build_staging
```

```bash
 make serve_staging
```

