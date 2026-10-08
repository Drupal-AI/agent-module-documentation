# Configuration

The module is configured from a single settings page that also lets you send a
test message so you can confirm delivery before you rely on it.

## Open the settings form

1. Log in as a user with the **Administer Sparkpost** permission (an administrator
   by default).
2. Go to **Configuration → Web services → Sparkpost**, or navigate directly to
   `/admin/config/services/sparkpost`.

## Enter your SparkPost credentials

On the settings form, supply your **SparkPost API key**. As covered in
[Installation](../installation/index.md), the recommended approach is to keep the
key in an environment variable and reference it through a **Key** entity rather
than storing the raw key in configuration that gets exported — the key can send
mail as your domain and read delivery data, so it must be treated as a secret and
scoped to sending only.

## Route Drupal's mail through SparkPost

For SparkPost to actually carry your mail, Drupal's mail system needs to use this
module as its mail backend (typically configured through the Mail System module).
Once that is in place, messages such as password resets, order confirmations and
account activations are handed to SparkPost for delivery instead of the local
`mail()` function.

## Send a test message

The settings page includes a **test-send form**. Use it to send a message to an
address you control and confirm it arrives. This is the quickest way to verify
your API key and mail routing are correct before real transactional mail depends
on them.

## Save and monitor

Save the configuration when you are done. After go-live, keep an eye on
SparkPost's **bounce and rejection reporting** in the provider dashboard — if the
provider becomes unreachable or the key is rotated without updating the site,
Drupal's mail can stop silently, and the provider's reporting is what tells you
before a user does.
