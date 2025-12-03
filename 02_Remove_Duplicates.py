# 02_Remove_Duplicates.py

text = input("Enter a string: ")

unique = ""

for char in text:
    if char not in unique:
        unique += char

print("Unique string:", unique)
