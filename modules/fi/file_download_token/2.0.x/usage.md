<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
File Download Token provides a tokenized link by which a file can be downloaded.

---

File Download Token provides a **tokenized download link** — a `/token-download/{token}` URL that lets the
holder download a specific file, without exposing the file's real path or requiring a login. It ships a
`file_download_token_webform` submodule, core 10.3+.

Use it to hand out time-limited download links (e.g. after a form submission or purchase). It is an
access/file-delivery feature and its design is sound: the token is a **strong CSPRNG value**
(`Crypt::randomBytesBase64(55)` — ~440 bits, unguessable), it is bound to a specific file (the route takes only
`{token}`, so the file comes from the token record — you can't swap in another file id), and tokens are
**expired/cleaned up after 24 hours**. Understand its model: the token is a **capability** — anyone who has the
URL can download the file (the route is public by design), so **deliver the link over a secure channel** (it's
as sensitive as the file), don't put highly sensitive files behind a link that could be forwarded, and rely on
the expiry. It has no per-user access-control role. Configure and issue download tokens.

---

- Provide tokenized download links.
- Download a file via /token-download/{token}.
- Hide the file's real path.
- Ship a Webform submodule.
- Use a strong CSPRNG token (randomBytesBase64(55)).
- Bind the token to a specific file.
- Expire/clean up tokens after 24h.
- TREAT the token as a capability (URL = access).
- Deliver the link over a secure channel.
- Not forward links to highly-sensitive files.
- Have no per-user access-control role.
- Configure and issue tokens.
- Handle download tokens.
- Issue links.
- Configure the tokens.
- Download by token.
- Handle the delivery.
- Tokenize downloads.
- Secure the link delivery.
- Provide tokenized downloads.
