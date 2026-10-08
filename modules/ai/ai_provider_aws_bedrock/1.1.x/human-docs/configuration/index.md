# Configuration

Bedrock authenticates with **AWS IAM**, so configuration means giving the provider
an AWS region plus AWS credentials — supplied through environment variables and
the Key module, never written into plain configuration.

## 1. Prepare AWS

1. In the AWS console, make sure **Bedrock** is available in the region you want to
   use (for example `us-east-1`), and that you have **requested access** to the
   specific foundation models you intend to call (Claude, Titan, etc.).
2. Create an **IAM user or role** that is allowed to invoke those models — at
   minimum the `bedrock:InvokeModel` action (and the streaming variant if you use
   streaming). Where your hosting allows it, prefer an **IAM role** over long-lived
   access keys.
3. If you are using access keys, note the **access key ID** and **secret access
   key**.

## 2. Store credentials as secrets (env → Key entities)

Put the credentials in environment variables. With DDEV:

```bash
ddev dotenv set .ddev/.env --aws-access-key-id=AKIA... --aws-secret-access-key=YOUR_SECRET
ddev restart
```

That exposes `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` inside the container
(keep `.ddev/.env` out of version control). Then create a Key entity for each at
**Configuration → System → Keys → Add key** (`/admin/config/system/keys/add`):

- **Key type:** Authentication.
- **Key provider:** Environment.
- **Environment variable:** `AWS_ACCESS_KEY_ID` (and a second key for
  `AWS_SECRET_ACCESS_KEY`).

## 3. Configure the provider

1. Log in as a user with the **administer ai providers** permission.
2. Go to **Configuration → AI → Providers → AWS Bedrock**
   (`/admin/config/ai/providers/aws_bedrock`).
3. Set the **AWS region** that matches where you enabled Bedrock.
4. Select the **Key** entities holding your access key ID and secret access key.
   (If you are using an assumed IAM role from the instance environment instead,
   configure it per the AWS module's guidance rather than static keys.)
5. Save.

## 4. Select a model

Choose **AWS Bedrock** and a specific model wherever the AI module offers a
provider choice — for example as the default chat provider, or on an individual AI
feature such as translation or summarisation.

## Why this is often the approvable option

Because Bedrock runs inside your own AWS account, model usage sits under the same
IAM policies, billing and **data-residency** arrangements as the rest of that
account. Prompts stay within your cloud tenancy rather than going to a public API
endpoint — frequently the difference between an AI feature being approvable and
not.
