# تقويم العمر · Age → Birth Year (Hijri & Gregorian)

صفحة React بسيطة: أدخل عمرك لتعرف سنة ميلادك بالتقويمين **الهجري** و**الميلادي**.

A single-page React app: enter your age and it shows your likely birth year in both the **Hijri** and **Gregorian** calendars.

## المميزات / Features

- إدخال العمر بالسنوات فقط (الحقل المطلوب الوحيد) — *age in years only*
- عرض سنة الميلاد كنطاق لأن تاريخ الميلاد الدقيق غير معروف — *birth year shown as a range*
- تحويل هجري دقيق عبر `Intl.DateTimeFormat` بتقويم `islamic` (بدون مكتبات خارجية) — *accurate Hijri conversion, no external libraries*
- واجهة عربية RTL بتصميم "إسطرلاب فلكي" وخط Cairo — *Arabic RTL "astrolabe" theme, Cairo font*

## التشغيل / Run

لا يحتاج إلى بناء — افتح الملف مباشرة في المتصفح:

No build step required — just open the file in a browser:

```
index.html
```

التقنيات: React 18 + Babel standalone عبر CDN.

Built with React 18 + Babel standalone via CDN.
