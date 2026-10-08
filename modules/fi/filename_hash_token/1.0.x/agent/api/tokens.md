<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Filename Hash tokens

Tokens registered under the **`file`** token type (all examples use filename `Example_File.txt`):

| Token | Result | Notes |
|-------|--------|-------|
| `[file:name-hash]` | `2923b18d012d783db62a172af46da20f` | Full `md5()` of the file basename (32 hex chars). |
| `[file:name-hash-substring:4]` | `2923` | First 4 chars (offset 0). |
| `[file:name-hash-substring:2,3]` | `3b` | 2 chars starting at offset 3 (`LENGTH,OFFSET`). |

Rules (from `hook_tokens`):
- The substring token is **dynamic**; arguments are `LENGTH` or `LENGTH,OFFSET`.
- A non-numeric `OFFSET` falls back to `0`.
- A value is only returned when `LENGTH` is numeric **and ≤ 32**.
- The hash is computed from `\Drupal::service('file_system')->basename($file->filename->value)`.

## Common use — File (Field) Paths
Set a file field's directory (or File (Field) Paths pattern) to something like:
```
public://uploads/[file:name-hash-substring:2]/[file:name-hash-substring:2,2]
```
to spread uploads across many subdirectories and keep any single folder small. No module configuration is
required; the Token module gives a UI for browsing these tokens.
