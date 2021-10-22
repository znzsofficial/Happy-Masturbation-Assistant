require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.graphics.drawable.ColorDrawable"
import "com.androlua.Ticker"
import "android.content.Context"
import "android.text.TextWatcher"
import "module"
import "diyzd_layout"
activity.setTheme(android.R.style.Theme_Material)
activity.setContentView(loadlayout("diyzd_layout"))
activity.getActionBar().setDisplayHomeAsUpEnabled(true)
activity.ActionBar.setTitle('自定义震动')
activity.ActionBar.setBackgroundDrawable(ColorDrawable(0xff009688))
activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE|WindowManager.LayoutParams.SOFT_INPUT_STATE_HIDDEN)
--分割状态栏，去除阴影效果,若想改颜色必用此效果
activity.getWindow().clearFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS | WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION);
--设置状态栏背景颜色
activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(0xFF009688);
--设置过渡动画
activity.overridePendingTransition(android.R.anim.fade_in,android.R.anim.fade_out)
function onOptionsItemSelected(item)
  local id=item.getItemId()
  if id==android.R.id.home then
    activity.finish()
    activity.newActivity("main")
  end
end


zdd.foreground=波纹特效v2(0x4Fffffff)


zdd.onClick=function()
  if edit.Text=="" then
    return true
   else
    周期=tonumber(edit.Text)
    if edit2.Text=="" then
      return true
     else
      时长=tonumber(edit2.Text)
    end
  end
  ti=Ticker()
  ti.Period=周期
  ti.onTick=function()
    震动(时长)
  end
  ti.start()
  function onPause()
    ti.stop()
  end
  function onStop()
    ti.stop()
  end
end


--返回键回到主页面
function onKeyDown(code,event)
  if code == KeyEvent.KEYCODE_BACK then
    activity.finish()
    activity.newActivity("main")
  end
end


--输入文本设置
local function TextChanged(v)
  return TextWatcher{
    onTextChanged=function(n)
      if #n>=9 then
        v.setText(tostring(n):sub(0,8)).setSelection(#v.text)
      end
      if v.text=="" then
        v.setError("数值不能为空")
      end
  end}
end

edit.addTextChangedListener(TextChanged(edit))
edit2.addTextChangedListener(TextChanged(edit2))

import "android.view.View$OnFocusChangeListener"
edit.setOnFocusChangeListener(OnFocusChangeListener{
  onFocusChange=function(v,hasFocus)
    if hasFocus then
      t.setTextColor(0xFD009788)
    end
  end})
edit2.setOnFocusChangeListener(OnFocusChangeListener{
  onFocusChange=function(v,hasFocus)
    if hasFocus then
      t2.setTextColor(0xFD009788)
    end
  end})