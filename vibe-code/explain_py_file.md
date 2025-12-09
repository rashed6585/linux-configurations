# 🧠 Vibe Coding Prompt Template

> **Task**: You are given a Python file **modules_clean.py**. Analyze it and produce structured documentation in **Markdown format** with the following rules to ensure clarity, maintainability, and transparency.

---

### 1. Class-Level Explanation
- **Objective**:
  - What is the purpose of this class?
  - Any assumptions or constraints?

---

### 2. Method-Level Explanation

For each method in the class:

- **Purpose**:
  - What does this method do, provide explanation in **bullet points**?
  - How does it support the class objective?

- **Arguments**:
  - List each argument as a sub-bullet:
    - `argument_name`:
      - **Type**: `str`, `int`, `DataFrame`, etc.
      - **Description**: What is it used for?
      - **Default**: If applicable, what is the default and why?

- **Returns**:
  - What does the method return?
  - Type and meaning of the return value.

---

### 3. Function-Level Explanation (if any standalone functions exist)

For each function outside the class:

- **Purpose**:
  - What does this function do?
  - Why is it separate from the class?

- **Arguments**:
  - List each argument as a sub-bullet:
    - `argument_name`:
      - **Type**
      - **Description**
      - **Default** (if any)

- **Returns**:
  - Type and meaning of the return value.

---

