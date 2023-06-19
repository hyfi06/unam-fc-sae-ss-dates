# Social Service Dates Calculator

This repository contains a codebase written in R to calculate dates for social service. This code will help the students of the Faculty of Sciences of the UNAM in the programming of social service activities.

# Usage

To use, follow the steps below:

1. Clone the repository to your local machine.
2. Ensure you have R installed on your system.
3. Update the 'data/unam-non-working-days' file to include any specific non-working days on interval you will use.
4. Run R and install packages with:
```R
install.packages()
```
5. Run script with `Rscript`

# Scripts

## Generate table of social servicie dates between two dates

Run next command on your terminal.

```bash
Rscript scripts/generate_table.R 20230101 20231231 2023.txt
```

## Calculate social service dates by start date

Run next command on your terminal.

```bash
Rscript scripts/calculator.R 20230619
```

# License

This project is licensed under the [MIT License](/LICENSE), which means you are free to use, modify, and distribute the code for both commercial and non-commercial purposes. However, the software is provided "as is," without any warranty or guarantee of its effectiveness or suitability for your specific needs. Please review the license file for more details.
