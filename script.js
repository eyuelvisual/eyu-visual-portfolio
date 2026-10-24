const menuToggle=document.getElementById('menuToggle');const nav=document.getElementById('mainNav');
menuToggle.addEventListener('click',()=>nav.classList.toggle('open'));
nav.querySelectorAll('a').forEach(a=>a.addEventListener('click',()=>nav.classList.remove('open')));
document.getElementById('year').textContent=new Date().getFullYear();

document.querySelectorAll('.filter').forEach(btn=>btn.addEventListener('click',()=>{
  document.querySelectorAll('.filter').forEach(b=>b.classList.remove('active'));btn.classList.add('active');
  document.querySelectorAll('.work-card').forEach(card=>{card.hidden=btn.dataset.filter!=='All'&&card.dataset.category!==btn.dataset.filter;});
}));

const adminDialog=document.getElementById('adminDialog');
document.getElementById('adminOpen').addEventListener('click',()=>adminDialog.showModal());
const orderDialog=document.getElementById('orderDialog');
document.querySelectorAll('.order-button').forEach(btn=>btn.addEventListener('click',()=>{
  const plan=btn.dataset.plan;const sel=document.getElementById('planSelect');
  sel.value=plan==='Basic'?'Basic — 250 ETB':plan==='Pro'?'Pro — 350 ETB':'Premium — 450 ETB';
  orderDialog.showModal();
}));
document.getElementById('goToForm').addEventListener('click',()=>{orderDialog.close();document.getElementById('contact').scrollIntoView({behavior:'smooth'});document.getElementById('clientName').focus({preventScroll:true});});

document.getElementById('orderForm').addEventListener('submit',e=>{
  e.preventDefault();const d=new FormData(e.currentTarget);
  const message=[
    'Hello EYU_VISUAL! I would like to discuss a design project.',
    `Name: ${d.get('name')}`,
    `Contact: ${d.get('contact')}`,
    `Service: ${d.get('type')}`,
    `Package: ${d.get('plan')}`,
    `Project details: ${d.get('details')||'Not provided'}`
  ].join('\n');
  window.open('https://t.me/Eyu_visual?text='+encodeURIComponent(message),'_blank','noopener');
});

// Admin uploads deliberately remain disabled until a real auth/database backend is configured.
// Never store passwords or admin credentials in this front-end file.
