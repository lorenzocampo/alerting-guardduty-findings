# Alerting Amazon GuardDuty findings

Terraform code that creates a solution that sends an email when an Amazon GuardDuty Finding is registered. It implements the following resources:

* **[EventBridge Event Rule]**.
* **[SNS Topic]**.
* **[SNS Email Subscription]**.

[EventBridge Event Rule]: https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-rules.html
[SNS Topic]:          https://docs.aws.amazon.com/sns/latest/dg/sns-create-topic.html
[SNS Email Subscription]: https://docs.aws.amazon.com/sns/latest/dg/sns-create-subscribe-endpoint-to-topic.html


## How It Works

1. An Event Rule monitors Amazon GuardDuty findings events.
2. When an event is registered, the Event Rule sends it to the SNS Topic, applying input and output transformation in order to extract the most valuable information of the event.
4. The SNS topic notifies the subscribed emails.


## Usage

1. Clone the repository

    ```
    $ git clone https://github.com/lorenzocampo/alerting-guardduty-findings.git
    ```

2. Initialize a working directory containing Terraform configuration files:

    ```
    $ terraform init
    ```

3. Create an execution plan, which lets you preview the changes that Terraform plans to make to your infrastructure

    ```
    $ terraform plan
    ```

4. Executes the actions proposed in a Terraform plan

    ```
    $ terraform apply
    ```