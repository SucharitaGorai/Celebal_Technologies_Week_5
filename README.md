# 🎓 SQL Project - Subject Allotment Tracker

## 📌 Problem
Colleges need to track **Open Elective subject changes** made by students over time — not just the current subject.

---

## 📁 Tables Used

### 1. `SubjectAllotments`
- Tracks current and previous subject choices.
- Columns: `StudentID`, `SubjectID`, `Is_Valid` (1 = current, 0 = previous)

### 2. `SubjectRequest`
- New subject requests by students.
- Columns: `StudentID`, `SubjectID`

---

## 🛠️ Task
Write a **stored procedure** to:
1. Check if requested subject ≠ current subject.
2. If different:
   - Insert new subject (`Is_Valid = 1`)
   - Update old subjects to `Is_Valid = 0`
3. If student not in `SubjectAllotments`:
   - Insert as new record (`Is_Valid = 1`)

---

## ✅ Outcome
Maintains full **subject change history** and **active status**, ensuring visibility into all previous selections.

---

**Internship Task - Celebal Technologies**
