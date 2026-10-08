<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Git Info exposes the site's Git repository information (branch, commit) through a block and tokens, reading it from the .git metadata.

---

Git Info exposes the deployed code's Git information — the current branch and commit — through a block
(`InfoBlock`) and tokens, reading it from the repository's `.git` metadata via the `eiriksm/git-info`
library (no shell execution and no user input, so no command-injection surface). This is handy for
developers/ops to confirm exactly which commit is deployed on an environment. It provides its own
permissions.

Use it to surface the deployed commit for debugging/release verification. **Security caveat — do not
expose the Git commit/branch to the public.** The commit hash is version-fingerprinting information: shown
on a public page (via the block or a token in a public template), it tells anyone the exact deployed
code version, which aids attackers in targeting known vulnerabilities for that version. Keep the block/
tokens on admin-only or internal pages (or gate by permission), not on the public front end. It reads git
metadata and has no access-control role of its own.

---

- Show the deployed Git branch/commit.
- Expose git info via a block.
- Provide git tokens.
- Read from .git metadata.
- Use the eiriksm/git-info library (no shell).
- Confirm the deployed commit.
- Provide its own permissions.
- NOT expose the commit publicly.
- Keep the block on admin/internal pages.
- Understand commit = version fingerprint.
- Avoid aiding version-targeted attacks.
- Gate by permission.
- Verify releases with git info.
- Debug deployments.
- Read branch and commit.
- Have no command-injection surface.
- Have no access-control role.
- Surface build info internally.
- Confirm environment version.
- Restrict git-info visibility.
