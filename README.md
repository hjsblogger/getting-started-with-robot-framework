# Getting Started With Robot Framework In Python

![RobotFramework_Logo](https://github.com/user-attachments/assets/80317436-3905-4c43-8d87-9a64ee10e5a5)
<div align="center"><a href="https://miro.medium.com/v2/resize:fit:700/1*AqIB9Nfeq-7lYhOCF7aLGA.png">Image Credit</a></div>
<br/>

Perform the following steps for running Robot tests on local machine or LambdaTest Cloud Grid

## Installation of Python packages

Packages that need to be installed are present in *pyproject.toml* Execution is performed on the LambdaTest Selenium Grid. We are using latest Selenium version for the execution. Install the project dependencies by running ```poetry install``` or ```poetry install --no-root``` on the terminal

<img width="742" alt="1" src="https://github.com/user-attachments/assets/4f83a10b-8f3b-423f-ad99-6e10c034ab24">

The global dependencies (i.e. Robot Framework and latest Selenium) are installed by running ```pip install -r requirements.txt``` or ```pip3 install -r requirements.txt```on the terminal

<img width="1123" alt="2" src="https://github.com/user-attachments/assets/fd541358-69e5-42e8-ae2d-9e950f41fbec">

## Configure Environment Variables

Before the tests are run, please set the environment variables LT_USERNAME & LT_ACCESS_KEY from the terminal. The account details are available on your [LambdaTest Profile](https://accounts.lambdatest.com/detail/profile) page.

For macOS:

```bash
export LT_USERNAME=LT_USERNAME
export LT_ACCESS_KEY=LT_ACCESS_KEY
```

For Linux:

```bash
export LT_USERNAME=LT_USERNAME
export LT_ACCESS_KEY=LT_ACCESS_KEY
```

For Windows:

```bash
set LT_USERNAME=LT_USERNAME
set LT_ACCESS_KEY=LT_ACCESS_KEY
```

Since the same tests can be executed with Robot on local machine and Robot on LambdaTest cloud grid, the environment variable EXEC_PLATFORM also needs to be set before execution.

For execution with Robot on local machine:
```bash
export EXEC_PLATFORM=local
```

For execution with Robot on LambdaTest cloud grid:
```bash
export EXEC_PLATFORM=cloud
```

## Execution of Robot Tests

The Robot tests are located in the [Common folder](https://github.com/hjsblogger/getting-started-with-robot-framework/tree/main/Tests/Common). Hence, there is a flexibility to run all the four tests with Robot on local as well cloud. Once the environment variables are set, run the command ```robot Tests/Common/<file-name.robot>``` on the terminal to trigger the test execution.

Shown below is the execution snapshot of Robot tests running on local machine:

<img width="1355" alt="robot-local-execution" src="https://github.com/user-attachments/assets/e9246f59-fbb7-4ec0-8f67-9e0f359561d1">

Shown below is the execution snapshot of Robot tests running on LambdaTest cloud grid:

As seen on the [LambdaTest Automation Dashboard](https://automation.lambdatest.com/build), the test execution is successful:

<img width="1111" alt="robot-cloud-execution-1" src="https://github.com/user-attachments/assets/9d6cb066-ab61-41bf-98d1-5a340d8f1021">

Here is the successful execution status as seen in the [LambdaTest Automation Dashboard](https://automation.lambdatest.com/build)

<img width="1432" alt="robot-cloud-execution-2" src="https://github.com/user-attachments/assets/258e7766-5fc9-49e1-932d-152b603825d6">


## Need Assistance?
Feel free to fork the repo and contribute to make it better! Email to [himanshu[dot]sheth[at]gmail[dot]com](mailto:himanshu.sheth@gmail.com) for any queries or ping me on the following social media sites:

<b>Twitter</b>: [@hjsblogger](https://www.twitter.com/hjsblogger)
<br/>
<b>LinkedIn</b>: [@hjsblogger](https://linkedin.com/in/hjsblogger)