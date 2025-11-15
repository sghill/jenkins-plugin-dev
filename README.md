# Jenkins Plugin Dev Container Feature

A [Dev Container Feature](https://containers.dev/implementors/features/) that automatically configures Maven for Jenkins plugin development.

## Usage

Add to your `.devcontainer/devcontainer.json`:

```json
{
  "image": "mcr.microsoft.com/devcontainers/java:17",
  "features": {
    "ghcr.io/sghill/jenkins-plugin-dev:1": {}
  }
}
```

This automatically configures Maven with:
- Jenkins CI repository (`https://repo.jenkins-ci.org/public/`)
- Proper `~/.m2/settings.xml` configuration
- Optional Jenkins incrementals repository (for testing unreleased versions)

## Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `repositoryUrl` | string | `https://repo.jenkins-ci.org/public/` | Jenkins Maven repository URL |
| `enableIncrementalBuild` | boolean | `false` | Enable Jenkins incrementals repository |
| `mavenVersion` | string | `latest` | Maven version (3.8, 3.9, latest) |
| `installLocation` | string | `user` | Install location (user, system, both) |

See [src/jenkins-plugin-dev/devcontainer-feature.json](src/jenkins-plugin-dev/devcontainer-feature.json) for all options.

## What This Replaces

Instead of manually maintaining:
- `.devcontainer/settings.xml`
- `.devcontainer/post-create.sh`

Just add this feature to your `devcontainer.json`.

## Development

To publish a new version:
1. Update `version` in `src/jenkins-plugin-dev/devcontainer-feature.json`
2. Commit and push to `main`
3. GitHub Actions will automatically publish to GHCR

## Learn More

- [Dev Containers](https://containers.dev/) - Specification and documentation
- [Dev Container Features](https://containers.dev/features) - Browse available features
- [Jenkins Plugin Development](https://www.jenkins.io/doc/developer/plugin-development/) - Jenkins plugin guide
