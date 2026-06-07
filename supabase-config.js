// ============================================================
//  إعداد Supabase — ضع هنا مفاتيح مشروعك
//  من: Supabase Dashboard → Project Settings → API
//
//  ⚠️  الـ anon key عام وآمن للاستخدام في الواجهة.
//      لا تضع هنا أبداً مفتاح service_role أو كلمة مرور قاعدة البيانات.
// ============================================================

window.SUPABASE_CONFIG = {
  url: "YOUR_SUPABASE_URL",       // مثال: https://abcdxyz.supabase.co
  anonKey: "YOUR_SUPABASE_ANON_KEY",
};

// عنوان الصفحة التي يُعاد إليها المستخدم بعد الدخول
window.APP_HOME = "index.html";

// تهيئة عميل Supabase المشترك (يُستخدم في جميع الصفحات)
window.getSupabase = function () {
  const { url, anonKey } = window.SUPABASE_CONFIG;
  if (!url || url === "YOUR_SUPABASE_URL" || !anonKey || anonKey === "YOUR_SUPABASE_ANON_KEY") {
    return null; // لم تُضبط المفاتيح بعد
  }
  if (!window.__supabaseClient) {
    window.__supabaseClient = window.supabase.createClient(url, anonKey);
  }
  return window.__supabaseClient;
};
