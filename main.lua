require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.content.Context"
import "android.content.res.ColorStateList"
import "android.net.Uri"
import "androidx.coordinatorlayout.R$id"
import "androidx.coordinatorlayout.widget.CoordinatorLayout"
import "com.google.android.material.button.MaterialButton"
import "com.google.android.material.card.MaterialCardView"
import "com.google.android.material.snackbar.Snackbar"
import "androidx.appcompat.widget.AppCompatTextView"
import "androidx.appcompat.widget.LinearLayoutCompat"
import "android.text.SpannableString"
import "android.text.style.ForegroundColorSpan"
import "android.text.Spannable"
import "android.graphics.drawable.GradientDrawable$Orientation"
import "android.graphics.drawable.GradientDrawable"
import "android.graphics.drawable.ColorDrawable"
import "layout"
import "module"
activity.setTheme(R.style.Theme_ReOpenLua_Material3)
activity.setContentView(loadlayout("layout"))
--activity.getSupportActionBar().setSubtitle('注意节制，自尊自爱')
times.getPaint().setFakeBoldText(true)
card0.foreground=波纹特效v2(0x4Fffffff)


--启动时读取数据
读取数据(mysp)
local a=tonumber(sp.getString("user",""))
if a==nil then
  a=0--初始化
  储存数据(tostring(a),mysp)
  times.Text="您还没有自慰哦"
 elseif a==0
  times.Text="您还没有自慰哦"
 else
  times.Text="您已自慰"..sp.getString("user","").."次"
end

card0.onLongClick=function()
  提示("智商封印official™")
end
--数据增加
card0.onClick=function()
  dialog=AlertDialog.Builder(this)
  .setTitle("标题")
  .setCancelable(true)
  --.setMessage([[]])
  .setPositiveButton("是的",{onClick=function(v)
      数据增加(1)
  end})
  .setNeutralButton("取消",{onClick=function(v)
  end})
  .show()
  dialog.create()
  sp = SpannableString("您确定已经进行了自慰吗？")
  sp.setSpan(ForegroundColorSpan(0xff000000),0,#sp,Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
  dialog.setTitle(sp)
  弹窗圆角(dialog.getWindow(),0xffffffff)
end


--重置次数
clean.onClick=function()
  读取数据(mysp)
  local b=tonumber(sp.getString("user",""))
  b=0
  储存数据(tostring(b),mysp)
  times.Text="您还没有自慰哦"
end

clean.onLongClick=function()
  activity.switchDayNight()
end

--计时器相关
chronoGraph.getPaint().setFakeBoldText(true)
submitButton.setVisibility(View.INVISIBLE)

local numTime = 0
function update()
  numTime = numTime + 1
  chronoGraph.Text="自慰中：您已经持续了"..numTime.."秒了"
end

startButton.onClick=function()
  --判断是否正在计时
  if isTiming==true then
    提示"正在计时"
   else
    --初始化 timer
    --timer 参数 = 执行，延迟，间隔，初始化
    myTimer = timer(function()
      call("update")
      end,200,1000, function()
    end)
    --启动timer定时器
    myTimer.Enabled=true
    --不知道在判断什么
    if unknownVariable==1 then
      submitButton.setVisibility(View.INVISIBLE)
      unknownVariable=0
     else
    end
    --用于判断计时器状态
    isTiming=true
  end
end

stop.onClick=function()
  --检测是否初始化
  if not myTimer then
    提示"请先开始"
    return
  end

  --暂停timer定时器
  chronoGraph.Text="自慰暂停：您本次自慰用时"..numTime.."秒"
  myTimer.Enabled=false
  --计时器状态设为关闭
  isTiming=false
end

endButton.onClick=function()
  --检测是否初始化
  if not myTimer then
    提示"请先开始"
    return
  end

  if numTime==nil then
    提示("你怎么这么快？")
   else
    --停止timer定时器
    myTimer.stop()
    myTimer = nil --注销计时器
    chronoGraph.Text="自慰结束：您本次自慰用时"..numTime.."秒"
    numTime=0
    if unknownVariable==1 then
     else
      submitButton.setVisibility(View.VISIBLE)
      缩放动画(submitButton)
      unknownVariable=1
    end
  end
  --计数器状态设为关闭
  isTiming=false
end

submitButton.onClick=function()
  数据增加(1)
    chronoGraph.Text="提交成功"
  submitButton.setVisibility(View.INVISIBLE)
end
