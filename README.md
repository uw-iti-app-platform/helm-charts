# helm-charts

## Releasing a change to your chart

### Packaging your change

This is not currently automated and should be done
before a PR until automation is set up.

```
helm package basic-web-service -d charts
helm repo index charts
```

### Publishing your change

This is only automated after the push to `gh-pages`.

```
git fetch
git switch gh-pages
git rebase main
git push 
```

After this, an Actions workflow will make your new chart 
version available for consumers.
