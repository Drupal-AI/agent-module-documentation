<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Download Token — agent index

Provides a **tokenized (capability) link (`/token-download/{token}`) to download a file** (no path exposure /
login). `file_download_token_webform` submodule. Version **2.0.0**. Core `^10.3||^11`.

Sound design: token is a **strong CSPRNG value** (`Crypt::randomBytesBase64(55)`, unguessable), **bound to a
specific file** (route takes only `{token}`), **24h expiry**. It's a **capability** — anyone with the URL
downloads (public route by design): **deliver over a secure channel**, don't forward links to highly-sensitive
files. No per-user access role.
