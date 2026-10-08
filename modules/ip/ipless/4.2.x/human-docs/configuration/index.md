# Configuration

Simple Less doesn't have a dedicated settings form. Its four options are added to
core's **Performance** page, and it stores them alongside core's own performance
settings. Nothing compiles until you turn the master switch on.

## Turn on Less compilation

1. Go to **Configuration → Development → Performance**
   (`/admin/config/development/performance`).
2. In the **Less CSS** area (inside "Bandwidth optimization"), tick **Less compilation
   enabled**.
3. Optionally tick the developer options described below.
4. Click **Save configuration**.

## The four settings

| Setting | What it does |
|---------|--------------|
| **Less compilation enabled** | The master switch. When **off**, the `less:` key is stripped out and nothing is compiled. When **on**, each declared Less file is compiled to CSS in `public://ipless/` and injected into its library. |
| **Less developer mode** | Recompiles the current page's Less on **every request**. Great while you are actively styling; leave it off in production so CSS is only rebuilt when needed. |
| **Enable SourceMap** | Emits source maps so your browser's dev tools can map compiled CSS back to the original Less. Only usable when developer mode is on. |
| **Enable watch mode** | Live-refreshes the CSS in the browser when you edit Less, without a full page reload. Only usable when developer mode is on. |

Source maps and watch mode are only available while developer mode is ticked — the
form greys them out otherwise.

> **Tip for production:** you can leave **Less compilation enabled** on while keeping
> developer mode, source maps and watch mode off. That serves plain compiled CSS with
> your normal aggregation/minification pipeline still working on the generated files.

### Setting it from the command line

Because the options live in core's `system.performance` config, you can script them:

```bash
# Enable compilation, and turn on developer mode too:
drush cset system.performance ipless.enabled 1 -y
drush cset system.performance ipless.modedev 1 -y

# Read the whole ipless mapping back:
drush cget system.performance ipless
```

On a fresh install the `ipless` settings are simply absent, which the module treats
as everything off.

## Declaring Less files

You tell Simple Less which files to compile by adding a `less:` key to a library
definition in your theme's or module's `*.libraries.yml`. For example, in
`mytheme.libraries.yml`:

```yaml
base:
  version: 1.0
  less:
    theme:
      css/styles.less: { output: css/gen/styles.css }
      css/foo.less: {}
```

- Each entry under `less:` is a `.less` file to compile.
- The optional `output:` key routes the compiled CSS to a specific path; without it,
  the module writes to `public://ipless/{extension}-{library}--{file}.css`.

When compilation is **enabled**, Simple Less compiles each `less` entry and injects
the resulting CSS as the library's stylesheet. When **disabled**, it removes the
`less` key entirely (and drops the library if it had no other CSS or JS). Attach the
library to your pages the normal way (for example via `libraries:` in your `.info.yml`
or with `#attached`).

## Precompiling for deployment

Rather than compiling on the first request after a deploy, precompile everything up
front:

```bash
drush ipless:generate   # alias: drush ipless
```

A cache flush (`drush cr`) also flags a full rebuild, so compiled CSS regenerates
after you clear caches.

## Requirements recap

For anything to compile you need the `wikimedia/less.php` library installed (it comes
in as a Composer dependency), and GD or your configured image toolkit isn't involved
here — this is pure CSS compilation. If the library is missing the module shows a
warning and skips compilation.
