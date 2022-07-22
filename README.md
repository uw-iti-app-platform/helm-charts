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
