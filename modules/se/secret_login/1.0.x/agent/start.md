<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Secret Login — agent index

**Log in as a configured user by visiting a secret URL**. Version **1.0.2**. Core `^9||^10||^11||^12`.

Routes: `/secret-login/access/{custom_path}` logs the visitor in as the configured user; `/secret-login/generate/{custom_path}` issues a token login URL (token valid ~1 hour, single-use). The path acts as the credential — use a high-entropy path.