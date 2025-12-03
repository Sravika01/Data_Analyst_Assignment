# 01_Time_Converter.py

minutes = int(input("Enter total minutes: "))

hours = minutes // 60
remaining_minutes = minutes % 60

# Correct plural/singular
hour_label = "hr" if hours == 1 else "hrs"
minute_label = "minute" if remaining_minutes == 1 else "minutes"

print(f"{hours} {hour_label} {remaining_minutes} {minute_label}")
