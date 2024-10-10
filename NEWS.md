# ChoiceModelR 1.3.1

- Fixed a bug in version 1.3.0. In version 1.3.0, an error message occurred when running choicemodelr with options restart=TRUE, demos is used, but no contraints are used. Version 1.3.1 corrects this bug.

---

# ChoiceModelR 1.3.0

- two new features to version 1.2: (1) Files RBetas.csv, RLog.txt, and restart.txt are saved to a directory specified by the argument, directory, of the choicemodelr function; (2) choicemodelr also saves the RLH values for each unit to the choicemodelr output object and to an RLH.csv file (saved to the specified directory).
