# helm-charts

## Releasing a change to your chart

### Packaging your change

You can use the included `./package-chart.sh` script which invokes
the `helm` CLI to package your change. You must have the `helm` CLI installed.

### Publishing your change

This is not automated currently.

```
git fetch
git switch gh-pages
git rebase origin/main
git push
```

After this, an Actions workflow will make your new chart
version available for consumers.

### Debugging

#### Did the new release get picked up by automation?

Compare the `sha256sum` of `charts/index.yaml` to what the HelmRepository `helm-chart-repository` says:

```
$ kubectl get helmrepository helm-chart-repository
NAME                    URL                                                         AGE    READY   STATUS
helm-chart-repository   https://uw-iti-app-platform.github.io/helm-charts/charts/   321d   True    stored artifact for revision '1ae29d2f07b8a9ec52f8eb5ccc03acbf6ad86b58a9a388fd880cfe29edda1782'


$ sha256sum charts/index.yaml
1ae29d2f07b8a9ec52f8eb5ccc03acbf6ad86b58a9a388fd880cfe29edda1782  charts/index.yaml
```

If they don't match check that you **actually published** by updating the `gh-pages` branch


#### Is the release valid?

Check an app that should be using that release via `kubectl get helmrelease YOUR_APP_NAME`

If you see an error there is no easy fix, but you can render the chart to see what happens and try and diagnose via `helm template basic-web-service/ | less`
