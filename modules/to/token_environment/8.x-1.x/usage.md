<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Token from Environment exposes selected environment variables as Drupal tokens, with an administrator-defined allowlist so only approved variables become tokens.

---

Some values a site needs at runtime live in the environment rather than in Drupal — an environment name (`production`/`staging`), a build identifier, a region, a feature flag set at deploy time. Surfacing those in content or configuration normally means custom code reading `getenv()`. Token from Environment makes them tokens instead, so `[environment:APP_ENV]`-style tokens resolve to the environment variable's value wherever tokens are used.

The security-critical design decision is handled correctly: it is an **allowlist**. An administrator defines, on the module's settings page, exactly which environment variables are exposed as tokens — the module does not blanket-expose the environment. The help text is explicit about why: "to ensure Drupal does not get access to any sensitive data." That matters enormously, because the environment is where secrets live — database passwords, API keys, the hash salt — and a token that rendered an arbitrary environment variable into page content or a log would be a direct secret-disclosure hole. The allowlist is what prevents that.

So the module is safe as designed, and the responsibility shifts to configuration: **never allowlist a variable that carries a secret.** A token can render into content, emails, and logs, all of which are more exposed than the environment itself, so exposing `DATABASE_PASSWORD` or an API key as a token would defeat every protection around it. Allowlist only non-sensitive operational values, and it is a clean way to surface deploy-time context.

---

- Expose an environment variable as a token.
- Show the environment name in content.
- Surface a build ID as a token.
- Use a deploy-time value in config.
- Allowlist safe environment variables.
- Resolve [environment:APP_ENV] in text.
- Avoid custom getenv() code.
- Show a region or stage.
- Surface a feature flag.
- Never allowlist a secret variable.
- Keep secrets out of tokens.
- Expose only non-sensitive vars.
- Use deploy context in content.
- Configure the variable allowlist.
- Show a staging banner from env.
- Reference an env token in patterns.
- Restrict what env is exposed.
- Surface operational metadata.
- Understand tokens render in logs.
- Keep the allowlist minimal.