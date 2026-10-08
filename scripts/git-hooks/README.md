# Leak-guard git hooks

Security findings for the documented modules are **local-only** and must never reach the
public GitHub repo. `.gitignore` already excludes the private artifacts; these hooks are the
active backstop so they can't be committed or pushed by mistake.

## What they block

- **pre-commit**
  1. Staging any **private security artifact**: a module-root `security.md` (a solution doc
     named `security.md` *under* an `agent/` dir is allowed), `SECURITY-FINDINGS.md`
     (and `.bak`s), or anything under `scripts/sec-scan/`.
  2. A **new** leak pointer added inside a public doc (`start.md` / `usage.md` /
     `agent/**/*.md`) — a `security.md` / `SECURITY-FINDINGS` / "local-only" reference to a
     private finding. Only *added* lines are checked, so pre-existing committed notes do not
     trip it.
- **pre-push** — refuses to push any commit whose diff contains a private security artifact.

## Activate (once per clone)

`core.hooksPath` is a local setting and is not shared by cloning, so each working copy runs:

```
git config core.hooksPath scripts/git-hooks
```

Intentional override (rare): `git commit --no-verify` / `git push --no-verify`.
