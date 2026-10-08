# Configuration

Static Suite is configured layer by layer. All of the settings and the
export/build/deploy configuration forms require the **Administer site
configuration** permission, and everything lives under **Configuration → Static**
(`/admin/config/static`).

Because this is a framework you adapt to your project, the sections below describe
what each layer configures rather than every individual field — the exact options
depend on the resolvers, builders, and deployers you enable.

## Static Export — data → files

The export layer serializes entities, config, and locale to data files. You
configure:

- The **data resolver** — GraphQL, JSON:API (endpoint `/jsonapi`), or a JSON
  serializer — which decides how each entity is turned into data.
- The **output format** (JSON, XML, YAML) and the **stream wrapper** that stores
  the files: `static-local` for a plain local directory, or `static-git` for a
  Git-backed, versioned data store (which needs a `git` binary on the server).
- The **work directory**, indexing, and which entity/config/locale items are
  exportable.

Export re-runs automatically when content changes, via CRUD event subscribers.

## Static Build — files → static site

The build layer runs your chosen Static Site Generator as a background process.
You configure:

- The **builder** to use for live and preview builds (Gatsby, Next.js, Eleventy,
  Hugo, Astro, and cloud builders such as AWS Lambda / CodeBuild).
- **Build trigger regexes** so that only relevant data changes cause a rebuild.
- The **base build directory**, the **number of releases to keep** (default 5), a
  semaphore timeout to prevent overlapping builds, and build **environment
  variables** (for example `CI=true`).

You can trigger a build on demand from the admin UI (with the *run builds on
demand* permission).

## Static Deploy — release → host/CDN

The deploy layer pushes a built release to a host or CDN through a deployer plugin
(for example `static_deployer_s3` for AWS S3). Its settings mirror the build
layer, and deployments can be run on demand (*run deployments on demand*).

## Releases and rollback

Releases are modeled as timestamped directories with a `current` symlink.
Publishing a release swaps that symlink atomically, so the switch is instant, and
old releases are pruned down to the *number of releases to keep* you configured —
which is what gives you rollback.

## Preview

Static Preview shows content changes without a full rebuild.
`static_preview_gatsby_instant`, if enabled, exposes per-page resolver endpoints
that take a request-supplied page path. Note that those instant-preview endpoints
are gated only by the *access content* permission, which on many sites is
effectively available to anonymous users — so enable that submodule only if that
access level is acceptable for your preview content.

## Access, logs, and safety notes

- **Settings and config forms:** *Administer site configuration*.
- **Logs:** `/admin/reports/static/*`, gated by *access site reports* plus the
  specific *view static … files/logs* permissions.
- **Export file viewer:** the `/static/export/files/…` viewer requires *view static
  export files*; its input is run through a path sanitizer (`FilePathSanitizer`)
  that strips `..` and other traversal tricks — the main guard where untrusted
  input meets the filesystem.
- **CLI execution:** you can restrict which users may run CLI commands with the
  `cli_allowed_users` setting.

The many build/deploy shell commands are **admin-only build tooling**: their
command strings come from your configuration, plugin annotations, and validated
internal release paths, and no HTTP request input reaches them. They are not shell
escaped, though, so treat your build and deploy configuration as trusted. TLS is
not disabled anywhere in the suite, and the single `unserialize()` call is
hardened with an allowed-classes list.
