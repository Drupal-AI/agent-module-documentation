# Filename Hash Token — manual setup guide

**Filename Hash Token** (`filename_hash_token`) defines a couple of Drupal **tokens**
that produce an md5 hash of a file's name, and configurable substrings of that
hash. Enable the module and the tokens become available anywhere Drupal tokens are
accepted — you don't need to configure anything.

It registers two tokens under the **`file`** token type:

- **`[file:name-hash]`** — the full 32‑character md5 hash of the file's basename.
  For the filename `Example_File.txt` this is `2923b18d012d783db62a172af46da20f`.
- **`[file:name-hash-substring:LENGTH]`** and
  **`[file:name-hash-substring:LENGTH,OFFSET]`** — a slice of that hash. For
  example `[file:name-hash-substring:4]` gives `2923` (the first 4 characters), and
  `[file:name-hash-substring:2,3]` gives `3b` (2 characters starting at offset 3).
  A value is only produced when the length is numeric and no more than 32; a
  non‑numeric offset falls back to 0.

The classic use is pairing the substring token with the
[File (Field) Paths](https://www.drupal.org/project/filefield_paths) module: hashing
the uploaded filename and taking a short substring lets you bucket files into many
subdirectories (for example `public://uploads/[file:name-hash-substring:2]/…`) so a
single folder does not accumulate thousands of files. Note the hash is a plain md5
of the *filename* — it is meant for spreading files across directories, **not** as
a security or integrity primitive (it is unsalted and not based on file contents).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

This module **requires no configuration** — enabling it makes the tokens available
immediately.

## How to use it

Once enabled, use the tokens anywhere token replacement is supported. The most
common place is a file field's **File directory** setting (or a File (Field) Paths
pattern), where a hashed subdirectory keeps folders small:

```
public://uploads/[file:name-hash-substring:2]/[file:name-hash-substring:2,2]
```

Installing the [Token](https://www.drupal.org/project/token) module is handy — it
gives you a browsable UI for finding and inserting these tokens — but it is not
required for the tokens to work.
