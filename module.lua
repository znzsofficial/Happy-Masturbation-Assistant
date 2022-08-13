
import "com.androlua.Ticker"
import "android.graphics.Color"
import "com.nirenr.Color"

--设置导航栏透明
activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION)



function 水珠动画(控件,时间)
  import "android.animation.ObjectAnimator"
  ObjectAnimator().ofFloat(控件,"scaleX",{1,.8,1.3,.9,1}).setDuration(时间).start()
  ObjectAnimator().ofFloat(控件,"scaleY",{1,.8,1.3,.9,1}).setDuration(时间).start()
end



function CircleButton(view,radiu,InsideColor,半圆)
  import "android.graphics.drawable.GradientDrawable"
  drawable = GradientDrawable()
  drawable.setShape(GradientDrawable.RECTANGLE)
  drawable.setColor(InsideColor)
  drawable.setCornerRadii({半圆,radiu,半圆,radiu,radiu,radiu,radiu,radiu});
  view.setBackgroundDrawable(drawable)
end


function 震动(时长)
  activity.getSystemService(Context.VIBRATOR_SERVICE).vibrate(long{0,时长},-1)
end


function 波纹特效v2(颜色)
  import"android.content.res.ColorStateList"
  return activity.Resources.getDrawable(activity.obtainStyledAttributes({android.R.attr.selectableItemBackground--[[Borderless]]}).getResourceId(0,0))
  .setColor(ColorStateList(int[0]
  .class{int{}},int{颜色 or 0x20000000}))
end



function 弹窗圆角(控件,背景色,上角度,下角度)
  if not 上角度 then
    上角度=25
  end
  if not 下角度 then
    下角度=上角度
  end
  控件.setBackgroundDrawable(GradientDrawable()
  .setShape(GradientDrawable.RECTANGLE)
  .setColor(背景色)
  .setCornerRadii({上角度,上角度,上角度,上角度,下角度,下角度,下角度,下角度}))
end


function 储存数据(str,参数)
  --获取SharedPreferences文件，后面的第一个参数就是文件名，没有会自己创建，有就读取
  sp = activity.getSharedPreferences(参数,Context.MODE_PRIVATE)
  --设置编辑
  sped = sp.edit()
  --设置键值对
  sped.putString("user",str)
  --提交保存数据
  sped.commit()
  --print("储存成功")
end


function 读取数据(参数)
  --获取SharedPreferences文件
  sp = activity.getSharedPreferences(参数,Context.MODE_PRIVATE)
  --打印对应的值
  --print(sp.getString("user",""))
end



function 数据增加(数据)
  读取数据(mysp)
  local a=tonumber(sp.getString("user",""))
  if a==nil then
    a=0
    times.Text="您还没有自慰哦"
   else
    a=a+数据
    储存数据(tostring(a),mysp)
    times.Text="您已自慰"..a.."次"
  end
end


function 缩放动画(控件)
  import "android.view.animation.*"
  控件.startAnimation(ScaleAnimation(0.0,1.0,0.0,1.0,1,0.5,1,0.5).setDuration(200))
end




function 通用数据增加(数据)
  读取数据(mysp)
  local a=tonumber(sp.getString("user",""))
  if a==nil then
    a=0
   else
    a=a+数据
    储存数据(tostring(a),mysp)
  end
end


function 提示(内容)
  local anchor=activity.findViewById(android.R.id.content)
  Snackbar.make(anchor, 内容, Snackbar.LENGTH_LONG).show()
  --LENGTH_SHORT     2s
  --LENGTH_LONG      3.5s
end

